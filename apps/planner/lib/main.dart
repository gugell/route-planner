import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:planner/app/app_router.dart';
import 'package:planner/common/di.dart';
import 'package:planner/screens/results/results_screen_bloc.dart';
import 'package:planner/screens/route_planner/route_screen_bloc.dart';

void main() async {
  await configureDependencies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter();

    return MultiBlocProvider(
        providers: [
          BlocProvider<RouteScreenBloc>(
            create: (_) => sl<RouteScreenBloc>(),
          ),
          BlocProvider<ResultsScreenBloc>(
              create: (_) => sl<ResultsScreenBloc>())
        ],
        child: MaterialApp(
          navigatorKey: router.navigatorKey,
          onGenerateRoute: router.onGenerateRoute,
          initialRoute: Routes.home,
        ));
  }
}
