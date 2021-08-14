import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pixelegram/application/get_it.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startClient();
  }

  startClient() async {
    Future.delayed(Duration(seconds: 2), () async {
      if (Platform.isAndroid || Platform.isIOS) {
        PermissionStatus perm = await Permission.storage.request();
        if (!perm.isGranted) {
          print('Permission.storage.request(): $perm');
        }
      }
      await GetIt.I<TelegramService>().start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/street.jpeg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
