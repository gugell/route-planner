class HttpRequest {
  final String path;
  final Map<String, dynamic>? queryParams;
  final Map<String, String>? headers;
  final dynamic body;

  HttpRequest({
    required this.path,
    this.queryParams,
    this.headers,
    this.body,
  });

  // Factory for GET requests
  factory HttpRequest.get({
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) {
    return HttpRequest(
      path: path,
      queryParams: queryParams,
      headers: headers,
    );
  }
}
