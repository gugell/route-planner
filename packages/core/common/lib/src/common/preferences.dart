import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Preferences {
  final String baseUrl;

  Preferences({required this.baseUrl});

  static Future<Preferences> loadFromEnvFile({String path = ".env"}) async {
    try {
      await loadEnvFile(path: path);
      return Preferences(baseUrl: dotenv.env['BASE_API_URL'] ?? "");
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}

Future<void> loadEnvFile({String path = ".env"}) async {
  try {
    await dotenv.load(fileName: path);
  } catch (e) {
    debugPrint(e.toString());
  }
}
