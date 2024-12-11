// http_test.dart

import 'package:core_api/src/http/http.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

final class MockHttp extends Mock implements Http {}

void main() {
  late MockHttp mockHttp;
  late Http httpClient;

  setUp(() {
    mockHttp = MockHttp();
    httpClient = mockHttp;
  });

  group('Http Client Tests', () {
    const testPath = '/test';
    const testResponseData = {'key': 'value'};

    test('should return data on success', () async {
      // Arrange
      final response = Response(
        data: testResponseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: testPath),
      );

      when(() => mockHttp.get(any(),
              queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => response);

      // Act
      final result = await httpClient.get(testPath);

      // Assert
      expect(result.data, testResponseData);
      expect(result.statusCode, 200);
      verify(() => mockHttp.get(testPath, queryParameters: null)).called(1);
    });

    test('should throw DioError on failure', () async {
      // Arrange
      final dioError = DioExceptionType.badResponse;

      when(() => mockHttp.get(any(),
          queryParameters: any(named: 'queryParameters'))).thenThrow(dioError);

      // Act & Assert
      expect(
        () async => await httpClient.get(testPath),
        throwsA(isA<DioExceptionType>()),
      );
      verify(() => mockHttp.get(testPath, queryParameters: null)).called(1);
    });
  });
}
