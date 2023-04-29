import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:xs_life/src/features/app/presentation/app.dart';
import 'package:xs_life/src/features/app/presentation/app_state.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("app_settings");
  runApp(ChangeNotifierProvider(
    create: (context) => AppState(),
    builder: ((context, child) => const App()),
  ));
}
