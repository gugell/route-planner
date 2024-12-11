import 'package:core_api/src/http/http_request.dart';

class RouteApiFactory {
  static HttpRequest getRoute({
    required String from,
    required String to,
  }) {
    final path = '/api/route/$from/$to';
    return HttpRequest.get(path: path);
  }
}
