import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'repositories/api.dart';
import 'repositories/repositories.dart';
import 'services/data_service.dart';


Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Repositories.init();
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((e) => print(e.toString()));
  runApp(const MyApp());
}


class MyApp extends StatefulWidget
{
  static final navKey = GlobalKey<NavigatorState>();

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> with WidgetsBindingObserver
{
  @override
  void initState()
  {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      ApiRepository.errorHandler = (msg) async {
        await _displayAlertDialog(
          title: 'Сетевая ошибка',
          text: msg,
          okText: 'Ok',
        );
      };
    });
  }

  @override
  void dispose()
  {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DataService(api: Repositories().api),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter GenoTek Demo',
        navigatorKey: MyApp.navKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }

  Future<bool> _displayAlertDialog({
    required final String title,
    required final String text,
    required final String okText,
  }) async {
    final context = MyApp.navKey.currentState?.context;
    if (context == null) return false;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(okText),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }
}
