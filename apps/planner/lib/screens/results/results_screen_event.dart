part of 'results_screen_bloc.dart';

@freezed
class ResultsScreenEvent with _$ResultsScreenEvent {
  const factory ResultsScreenEvent.initialize({required StepsDTO firstStep}) =
      Initialize;
  const factory ResultsScreenEvent.fetchWeatherForStep({
    required StepsDTO step,
  }) = FetchWeatherForStep;

  const factory ResultsScreenEvent.moveToStep({required StepsDTO step}) =
      MoveToStep;
}
