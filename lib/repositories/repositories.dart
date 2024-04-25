
import 'package:logging/logging.dart';
import 'api.dart';
import 'dio_helper.dart';


final _log = Logger('Repositories');


class Repositories
{
  late final ApiRepository api;

  static void init()
  {
    _instance = Repositories._();
  }

  factory Repositories() => _instance;

  Repositories._()
  {
    final dio = DioHelper.init();

    api = ApiRepository(dio: dio);
  }

  static late final Repositories _instance;
}
