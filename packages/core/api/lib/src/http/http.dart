import 'package:common/common.dart';

abstract class Http {
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters});
}
