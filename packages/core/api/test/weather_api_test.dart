import 'package:core_api/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockHttp mockHttp;

  late GetWeatherForecast getWeatherForecast;

  setUp(() {
    mockHttp = MockHttp();
    getWeatherForecast = GetWeatherForecast(http: mockHttp);
  });

  group('Get weather API Tests', () {
    const testPath = '/test';
    const okReponseStub = {"description": "clear sky", "temperature": 20};

    const invalidReponseStub = {"summary": "clear sky", "grades": 20};

    test('should return data on success', () async {
      // Arrange
      final response = Response(
        data: okReponseStub,
        statusCode: 200,
        requestOptions: RequestOptions(path: testPath),
      );

      when(() => mockHttp.get(any(),
              queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => response);

      // Act
      final result = await getWeatherForecast.call(lat: 43.0, lng: 2.0);

      // Assert
      expect(result.description, okReponseStub['description']);
      expect(result.temperature, okReponseStub['temperature']);
    });

    test('should throw TypeError when payload is invalid', () async {
      // Arrange
      final response = Response(
        data: invalidReponseStub,
        statusCode: 200,
        requestOptions: RequestOptions(path: testPath),
      );

      when(() => mockHttp.get(any(),
              queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => response);

      // Act
      // Assert
      expect(() async => await getWeatherForecast.call(lat: 43.0, lng: 2.0),
          throwsA(isA<TypeError>()));
    });
  });
}
