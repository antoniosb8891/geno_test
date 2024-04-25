import 'dart:async';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../models/price_entry.dart';


final _log = Logger('ApiRepository');


typedef ExceptionHandler = FutureOr<void> Function(String);


class ApiRepository
{
  ApiRepository({required final Dio dio}) : _dio = dio;

  Future<PriceEntryModel?> getPrice() async
  {
    try {
      final response = await _dio.get('/api/price');
      final result = PriceEntryModel.fromJsonOr(response.data, parent: null);
      return result;
    } catch (e, s) {
      _handleError(e.toString());
      Error.throwWithStackTrace(e, s);
    }
  }

  static Future<void> _handleError(final String message) async
  {
    if (errorHandler != null) {
      await errorHandler!(message);
    }
  }

  final Dio _dio;

  static ExceptionHandler? errorHandler;
}