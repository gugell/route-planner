part of 'route_screen_bloc.dart';

@freezed
class RouteScreenEvent with _$RouteScreenEvent {
  const factory RouteScreenEvent.getRoute(
      {required String from, required String to}) = GetRoutesEvent;
}
