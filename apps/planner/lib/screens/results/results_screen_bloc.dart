import 'package:core_api/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'results_screen_bloc.freezed.dart';
part 'results_screen_event.dart';
part 'results_screen_state.dart';

@injectable
class ResultsScreenBloc extends Bloc<ResultsScreenEvent, ResultsScreenState> {
  final GetWeatherForecast _getWeatherForecast;

  ResultsScreenBloc(this._getWeatherForecast)
      : super(const ResultsScreenState.initial()) {
    on<FetchWeatherForStep>((event, emit) async {
      try {
        // Fetch weather for the specific step
        final weather = await _getWeatherForecast.call(
          lat: event.step.location.lat,
          lng: event.step.location.lng,
        );

        emit(WeatherLoadedForStep(
          temperature: weather.temperature,
          description: weather.description,
          step: event.step,
        ));
      } catch (e) {
        emit(ResultsScreenState.error('Failed to fetch weather: $e'));
      }
    });
  }
}
