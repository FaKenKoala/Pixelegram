import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:global_configuration/global_configuration.dart';
import 'package:pixelegram/application/app_router.gr.dart';

import 'application/get_it.dart' show registerAll, NavigationService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("app");
  registerAll();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Pixelegram',
        theme: ThemeData.dark(),
        routeInformationParser: GetIt.I<AppRouter>().defaultRouteParser(),
        routerDelegate: GetIt.I<AppRouter>().delegate());
  }
}
