
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genotek_test/repositories/api.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_test.mocks.dart';
import 'src_json.dart';


@GenerateMocks([Dio])
void main()
{
  test('Check Api', () async
  {
    final mockDio = MockDio();
    final api = ApiRepository(dio: mockDio);

    when(mockDio.get('/api/price'))
      .thenAnswer((_) async {
      return Response(
        requestOptions: RequestOptions(),
        statusCode: 200,
        data: sourceJsonValue,
      );
    });

    await expectLater(api.getPrice(), completes);

    verify(mockDio.get('/api/price')).called(1);
  });
}