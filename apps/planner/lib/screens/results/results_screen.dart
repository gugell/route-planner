import 'package:carousel_slider/carousel_slider.dart';
import 'package:common/common.dart';
import 'package:core_api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:planner/components/step_carousel_card.dart';
import 'package:planner/components/step_marker.dart';
import 'package:planner/screens/results/results_screen_bloc.dart';

class ResultsScreen extends StatefulWidget {
  final RoutesResponseDTO route;

  const ResultsScreen({Key? key, required this.route}) : super(key: key);

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  int _currentStepIndex = 0;
  final _mapController = MapController();
  final _carouselController = CarouselSliderController();

  final Map<String, Map<String, dynamic>> _weatherCache =
      {}; // Cache for weather data

  @override
  void initState() {
    super.initState();

    // Schedule the call after the widget is fully built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      moveToStep(widget.route.steps[_currentStepIndex]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final polylinePoints = widget.route.steps
        .map((step) => LatLng(step.location.lat, step.location.lng))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Route Results')),
      body: BlocConsumer<ResultsScreenBloc, ResultsScreenState>(
        listener: (context, state) {
          if (state is WeatherLoadedForStep) {
            final step = state.step;
            final cacheKey = _getCacheKey(step);
            setState(() {
              _weatherCache[cacheKey] = {
                'temperature': state.temperature,
                'description': state.description,
              };
            });
          } else if (state is Error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          return Stack(children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                interactionOptions:
                    InteractionOptions(enableMultiFingerGestureRace: true),
                initialCenter: LatLng(
                  widget.route.steps.first.location.lat,
                  widget.route.steps.first.location.lng,
                ),
                initialZoom: 18.0,
                maxZoom: 18.3,
              ),
              children: [
                TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: polylinePoints,
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
                MarkerLayer(
                    markers: widget.route.steps.indexed
                        .map((i) => StepMarker(
                            step: i.$2,
                            onPressed: () =>
                                _carouselController.jumpToPage(i.$1)))
                        .toList()),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: widget.route.steps.length,
                itemBuilder: (context, index, realIndex) {
                  final step = widget.route.steps[index];
                  final cacheKey = _getCacheKey(step);
                  final weather = _weatherCache[cacheKey];

                  return StepCarouselCard(
                      step: step, index: index, weather: weather);
                },
                options: CarouselOptions(
                  height: 200.0,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentStepIndex = index;
                    });

                    moveToStep(widget.route.steps[index]);
                  },
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }

  void _moveMapToStep(StepsDTO step) {
    _mapController.move(
      LatLng(step.location.lat, step.location.lng),
      16.0, // Adjust zoom level
    );
  }

  void _fetchWeatherForStep(StepsDTO step) {
    final cacheKey = _getCacheKey(step);
    if (!_weatherCache.containsKey(cacheKey)) {
      context.read<ResultsScreenBloc>().add(FetchWeatherForStep(step: step));
    }
  }

  String _getCacheKey(StepsDTO step) {
    return '${step.location.lat},${step.location.lng}';
  }

  moveToStep(StepsDTO step) {
    _fetchWeatherForStep(step);
    _moveMapToStep(step);
  }
}
