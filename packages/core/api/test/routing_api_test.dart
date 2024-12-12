import 'package:core_api/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockHttp mockHttp;

  late GetRoutes getRoutes;

  setUp(() {
    mockHttp = MockHttp();
    getRoutes = GetRoutes(http: mockHttp);
  });

  group('Get routes API Tests', () {
    const testPath = '/test';
    const okReponseStub = {
      "duration": 44994,
      "distance": 1234617,
      "steps": [
        {
          "direction": "right",
          "location": {"lat": 48.8575475, "lng": 2.3513765}
        }
      ]
    };

    const invalidReponseStub = {
      "durations": 44994,
      "distance": 1234617,
      "steps": [
        {
          "direction": "right",
          "location": {"lat": 48.8575475, "lng": 2.3513765}
        }
      ]
    };

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
      final result = await getRoutes.call(from: 'Paris', to: 'Vienna');

      // Assert
      expect(result.distance, okReponseStub['distance']);
      expect(result.duration, okReponseStub['duration']);
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
      expect(() async => await getRoutes.call(from: 'Paris', to: 'Vienna'),
          throwsA(isA<TypeError>()));
    });
  });
}
