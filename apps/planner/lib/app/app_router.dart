import 'package:core_api/api.dart';
import 'package:flutter/material.dart';
import 'package:planner/screens/results/results_screen.dart';
import 'package:planner/screens/route_planner/route_planner_screen.dart';

class AppRouter {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final AppRouter _instance = AppRouter._internal();
  AppRouter._internal();
  factory AppRouter() => _instance;

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => RoutePlannerScreen());
      case Routes.results:
        return MaterialPageRoute(
            builder: (_) =>
                ResultsScreen(route: settings.arguments as RoutesResponseDTO));
      default:
        return MaterialPageRoute(builder: (_) => RoutePlannerScreen());
    }
  }

  void navigateTo(String routeName, {Object? arguments}) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  void goBack() {
    navigatorKey.currentState?.pop();
  }
}

class Routes {
  static const String home = '/';
  static const String results = '/results';
}
