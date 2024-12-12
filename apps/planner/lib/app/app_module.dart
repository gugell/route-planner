import 'package:common/common.dart';
import 'package:core_api/api.dart';

@module
abstract class AppModule {
  @preResolve
  Future<Preferences> get preferences => Preferences.loadFromEnvFile();

  // Synchronously initialize Http. No need for @preResolve.
  @singleton
  Http http(Preferences preferences) {
    final http = DioHttp(baseUrl: preferences.baseUrl);
    return http;
  }

  @singleton
  GetWeatherForecast getWeatherForecast(Http http) =>
      GetWeatherForecast(http: http);

  @singleton
  GetRoutes getRoutes(Http http) => GetRoutes(http: http);
}
