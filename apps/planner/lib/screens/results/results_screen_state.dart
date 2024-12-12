part of 'results_screen_bloc.dart';

@freezed
class ResultsScreenState with _$ResultsScreenState {
  const factory ResultsScreenState.initial() = Initial;
  const factory ResultsScreenState.error(String message) = Error;
  const factory ResultsScreenState.weatherLoadedForStep({
    required double temperature,
    required String description,
    required StepsDTO step,
  }) = WeatherLoadedForStep;

  const factory ResultsScreenState.stepMoved({
    required StepsDTO step,
  }) = StepMoved;
}
