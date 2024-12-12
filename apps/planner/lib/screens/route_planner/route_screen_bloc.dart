import 'package:core_api/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route_screen_bloc.freezed.dart';
part 'route_screen_event.dart';
part 'route_screen_state.dart';

@injectable
class RouteScreenBloc extends Bloc<RouteScreenEvent, RouteScreenState> {
  final GetRoutes _getRoutes;

  RouteScreenBloc(this._getRoutes) : super(const Initial()) {
    on<GetRoutesEvent>((event, emit) async {
      emit(const Loading());
      try {
        final route = await _getRoutes.call(from: event.from, to: event.to);
        if (route.steps.isEmpty) {
          emit(Error('No route found'));
          return;
        }
        emit(Success(route));
      } catch (e) {
        emit(Error(e.toString()));
      }
    });
  }
}
