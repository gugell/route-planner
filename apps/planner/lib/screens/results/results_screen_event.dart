part of 'results_screen_bloc.dart';

@freezed
class ResultsScreenEvent with _$ResultsScreenEvent {
  const factory ResultsScreenEvent.fetchWeatherForStep({
    required StepsDTO step,
  }) = FetchWeatherForStep;
}
