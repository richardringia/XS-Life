import 'package:flutter/material.dart';
import 'package:xs_life/src/features/example_map_screen/application/example_map_widget.dart';
import 'package:xs_life/src/features/main_screen/application/main_screen_widget.dart';
import 'package:global_configuration/global_configuration.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("app_settings");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XS Life',
      initialRoute: '/map',
      routes: {
        '/': (context) => const MainScreenWidget(),
        '/map': (context) => const ExampleMapWidget(),
      },
    );
  }
}

