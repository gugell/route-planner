import 'package:core_api/api.dart';

class RouteApiFactory {
  static HttpRequest getRoute({
    required String from,
    required String to,
  }) {
    final path = '/api/route/$from/$to';
    return HttpRequest.get(path: path);
  }
}

class GetRoutes {
  final Http http;

  GetRoutes({required this.http});
  Future<RoutesResponseDTO> call({
    required String from,
    required String to,
  }) async {
    final request = RouteApiFactory.getRoute(from: from, to: to);
    final response =
        await http.get(request.path, queryParameters: request.queryParams);

    return RoutesResponseDTO.fromJson(response.data); //response.data;
  }
}
