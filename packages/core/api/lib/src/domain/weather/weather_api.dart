import 'package:core_api/src/domain/weather/weather_response_dto.dart';
import 'package:core_api/src/http/http.dart';
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

class GetWeatherForecast {
  final Http http;

  GetWeatherForecast({required this.http});

  Future<WeatherResponseDTO> call({
    required double lat,
    required double lng,
  }) async {
    final request = WeatherApiFactory.getForecast(lat: lat, lng: lng);
    final response =
        await http.get(request.path, queryParameters: request.queryParams);

    return WeatherResponseDTO.fromJson(response.data);
  }
}
