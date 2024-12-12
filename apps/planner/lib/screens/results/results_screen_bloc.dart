import 'package:carousel_slider/carousel_controller.dart';
import 'package:core_api/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

part 'results_screen_bloc.freezed.dart';
part 'results_screen_event.dart';
part 'results_screen_state.dart';

@injectable
class ResultsScreenBloc extends Bloc<ResultsScreenEvent, ResultsScreenState> {
  final Map<String, Map<String, dynamic>> weatherCache = {};

  final GetWeatherForecast getWeatherForecast;

  final mapController = MapController();
  final carouselController = CarouselSliderController();

  ResultsScreenBloc({required this.getWeatherForecast})
      : super(const Initial()) {
    on<Initialize>(_onInitialize);
    on<MoveToStep>(_onMoveToStep);
    on<FetchWeatherForStep>(_onFetchWeather);
  }

  Future<void> _onInitialize(
      Initialize event, Emitter<ResultsScreenState> emit) async {
    // Move to the first step
    mapController.move(
      LatLng(event.firstStep.location.lat, event.firstStep.location.lng),
      16.0,
    );

    // Fetch weather for the first step
    add(FetchWeatherForStep(step: event.firstStep));
  }

  Future<void> _onMoveToStep(
      MoveToStep event, Emitter<ResultsScreenState> emit) async {
    final step = event.step;

    // Move map to the new step
    mapController.move(
      LatLng(step.location.lat, step.location.lng),
      16.0, // Adjust zoom level
    );

    emit(StepMoved(step: step));
  }

  Future<void> _onFetchWeather(
      FetchWeatherForStep event, Emitter<ResultsScreenState> emit) async {
    final step = event.step;
    final cacheKey = _getCacheKey(step);

    // Check cache first
    if (weatherCache.containsKey(cacheKey)) {
      final cachedData = weatherCache[cacheKey]!;
      emit(WeatherLoadedForStep(
        step: step,
        temperature: cachedData['temperature'],
        description: cachedData['description'],
      ));
      return;
    }

    // Fetch weather data
    try {
      final response = await getWeatherForecast.call(
        lat: step.location.lat,
        lng: step.location.lng,
      );
      final weatherData = {
        'temperature': response.temperature,
        'description': response.description,
      };

      // Cache the data
      weatherCache[cacheKey] = weatherData;

      emit(WeatherLoadedForStep(
        step: step,
        temperature: response.temperature,
        description: response.description,
      ));
    } catch (e) {
      emit(Error('Failed to fetch weather: $e'));
    }
  }

  String _getCacheKey(StepsDTO step) {
    return '${step.location.lat},${step.location.lng}';
  }
}
