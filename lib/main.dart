import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:global_configuration/global_configuration.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pixelegram/application/router/router.dart';

import 'application/get_it/get_it.dart' show registerDependencies;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("app");
  registerDependencies();
  initializeDateFormatting();
  // await MobileAds.instance.initialize();
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
