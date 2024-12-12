import 'package:carousel_slider/carousel_slider.dart';
import 'package:common/common.dart';
import 'package:core_api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:planner/components/step_carousel_card.dart';
import 'package:planner/components/step_marker.dart';
import 'package:planner/l10n/global.dart';
import 'package:planner/screens/results/results_screen_bloc.dart';

class ResultsScreen extends StatelessWidget {
  final RoutesResponseDTO route;

  int _selectedIndex = 0;

  ResultsScreen({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Trigger initialization when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ResultsScreenBloc>().add(
            Initialize(firstStep: route.steps.first),
          );
    });

    final polylinePoints = route.steps
        .map((step) => LatLng(step.location.lat, step.location.lng))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.routeResults)),
      body: BlocConsumer<ResultsScreenBloc, ResultsScreenState>(
        listener: (context, state) {
          if (state is WeatherLoadedForStep) {
            // Weather data is already handled by the Bloc; UI updates automatically
          } else if (state is Error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              FlutterMap(
                mapController: context.read<ResultsScreenBloc>().mapController,
                options: MapOptions(
                  initialCenter: LatLng(
                    route.steps.first.location.lat,
                    route.steps.first.location.lng,
                  ),
                  initialZoom: 16.0,
                  maxZoom: 18.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
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
                      markers: route.steps.indexed
                          .map((i) => StepMarker(
                              step: i.$2,
                              isSelected: i.$1 == _selectedIndex,
                              onPressed: () => context
                                  .read<ResultsScreenBloc>()
                                  .carouselController
                                  .jumpToPage(i.$1)))
                          .toList()),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CarouselSlider.builder(
                  carouselController:
                      context.read<ResultsScreenBloc>().carouselController,
                  itemCount: route.steps.length,
                  itemBuilder: (context, index, realIndex) {
                    final step = route.steps[index];
                    final weatherCache = context
                        .read<ResultsScreenBloc>()
                        .weatherCache[_getCacheKey(step)];
                    return StepCarouselCard(
                      step: step,
                      index: index,
                      weather: weatherCache,
                    );
                  },
                  options: CarouselOptions(
                    height: 200.0,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      _selectedIndex = index;
                      final step = route.steps[index];
                      context
                          .read<ResultsScreenBloc>()
                          .add(MoveToStep(step: step));
                      context
                          .read<ResultsScreenBloc>()
                          .add(FetchWeatherForStep(step: step));
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getCacheKey(StepsDTO step) {
    return '${step.location.lat},${step.location.lng}';
  }
}
