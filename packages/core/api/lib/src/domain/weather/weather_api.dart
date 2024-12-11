import 'package:core_api/src/http/http_request.dart';

class WeatherApiFactory {
  static HttpRequest getForecast({
    required double lat,
    required double lng,
  }) {
    final path = '/api/Weather/$lat/$lng';
    return HttpRequest.get(path: path);
  }
}
