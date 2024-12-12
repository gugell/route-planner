import 'package:intl/intl.dart' as intl;

import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get greeting => 'Hello, world!';

  @override
  String newMessages(num newMessages) {
    String _temp0 = intl.Intl.pluralLogic(
      newMessages,
      locale: localeName,
      other: '$newMessages new messages',
      one: 'One new message',
      zero: 'No new messages',
    );
    return '$_temp0';
  }

  @override
  String routingError(String message) {
    return 'Error: $message';
  }

  @override
  String get planRoute => 'PlanRoute';

  @override
  String get from => 'From';

  @override
  String get to => 'To';

  @override
  String get submit => 'Find a route';

  @override
  String get routeResults => 'Route results';

  @override
  String get distance => 'Distance';

  @override
  String formattedDuration(String duration) {
    return 'Duration: $duration';
  }

  @override
  String formattedDistance(String distance) {
    return 'Distance: $distance';
  }

  @override
  String get description => 'Description';

  @override
  String step(int index) {
    return 'Step $index';
  }

  @override
  String direction(String direction) {
    return 'Direction: $direction';
  }

  @override
  String formattedWeather(String temperature, String description) {
    return 'Temperature: $temperature°C\nDescription: $description';
  }
}
