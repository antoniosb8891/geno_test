import 'package:dio/dio.dart';
import 'package:logging/logging.dart';


final _log = Logger('Dio');


class DioHelper
{
  static Dio init()
  {
    return Dio()
      ..options..interceptors.add(LogInterceptor(
        request: false,
        requestHeader: false,
        requestBody: false,
        responseHeader: false,
        responseBody: true,
        logPrint: (o) => _log.info(o.toString()),
      ))
      ..options.baseUrl = 'https://back.genotek.ru';
  }
}