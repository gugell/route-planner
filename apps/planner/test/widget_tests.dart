import 'dart:async';

import 'package:common/common.dart';
import 'package:core_api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:planner/screens/results/results_screen.dart';
import 'package:planner/screens/route_planner/route_planner_screen.dart';
import 'package:planner/screens/route_planner/route_screen_bloc.dart';

class MockRouteBloc extends Mock implements RouteScreenBloc {}

class FakeRouteEvent extends Fake implements RouteScreenEvent {}

class FakeRouteState extends Fake implements RouteScreenState {}

void main() {
  late MockRouteBloc mockRouteBloc;
  late StreamController<RouteScreenState> streamController;

  setUp(() {
    mockRouteBloc = MockRouteBloc();
    streamController = StreamController<RouteScreenState>();
  });

  tearDown(() {
    streamController.close();
  });

  testWidgets('fills text fields, fetches data, and navigates to ResultsScreen',
      (WidgetTester tester) async {
    when(() => mockRouteBloc.stream).thenAnswer((_) => streamController.stream);
    when(() => mockRouteBloc.state).thenReturn(const Initial());
    // Render the main screen wrapped with BlocProvider
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<RouteScreenBloc>.value(
          value: mockRouteBloc,
          child: RoutePlannerScreen(),
        ),
      ),
    );

    // Act: Enter text into the fields
    const fromText = 'Paris';
    const toText = 'Vienna';

    await tester.enterText(find.byKey(const Key('fromTextField')), fromText);
    await tester.enterText(find.byKey(const Key('toTextField')), toText);

    // Tap the button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // Allow UI updates

    // Emit Loading state
    streamController.add(const Loading());
    await tester.pump(); // Allow UI updates

    // Emit Loaded state with mock data
    streamController.add(Success(RoutesResponseDTO(
      duration: 120,
      distance: 1000,
      steps: [
        StepsDTO(
          direction: '->',
          location: LocationDTO(lat: 48.8566, lng: 2.3522),
        ),
      ],
    )));
    await tester.pumpAndSettle(); // Wait for navigation
    // Assert: Verify that navigation occurred
    expect(find.byType(ResultsScreen), findsOneWidget);

    // Verify data passed to ResultsScreen
    expect(find.text('Step 1'), findsOneWidget);
    expect(find.text('Direction: ->'), findsOneWidget);

    // Close the stream
    streamController.close();
  });
}
