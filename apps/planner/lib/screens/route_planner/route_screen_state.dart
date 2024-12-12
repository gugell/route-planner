part of 'route_screen_bloc.dart';

@freezed
class RouteScreenState with _$RouteScreenState {
  const factory RouteScreenState.initial() = Initial;
  const factory RouteScreenState.loading() = Loading;
  const factory RouteScreenState.success(RoutesResponseDTO response) = Success;
  const factory RouteScreenState.error(String message) = Error;

  const factory RouteScreenState.weatherLoadedForStep({
    required double temperature,
    required String description,
    required StepsDTO step,
  }) = WeatherLoadedForStep;
}
