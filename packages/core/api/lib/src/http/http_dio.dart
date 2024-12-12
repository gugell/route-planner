import 'package:common/common.dart';
import 'package:core_api/src/http/http.dart';

class DioHttp implements Http {
  final Dio _dio;

  DioHttp(
      {required String baseUrl,
      Duration connectionTimeout = const Duration(seconds: 30),
      Duration receiveTimeout = const Duration(seconds: 30)})
      : _dio = Dio(BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: connectionTimeout,
            receiveTimeout: receiveTimeout)) {
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
  }
  @override
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }
}
