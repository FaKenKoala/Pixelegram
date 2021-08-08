import 'dart:async';
import 'dart:io' show Directory, Platform;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' show ChangeNotifier, Navigator;
import 'package:get_it/get_it.dart' show GetIt;
import 'package:global_configuration/global_configuration.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory, getTemporaryDirectory;

import 'package:libtdjson/libtdjson.dart' show Service;
import 'package:pixelegram/application/app_router.gr.dart';
import 'package:pixelegram/presentation/login/auth_code_page.dart';

import 'get_it.dart' show NavigationService, LogService;

class TelegramService extends ChangeNotifier {
  Service? _service;
  Function(dynamic s) _log = LogService.build('TelegramService');

  TelegramService() {
    _init();
  }

  _init() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    Directory tempDir = await getTemporaryDirectory();
    if (Platform.isAndroid || Platform.isIOS) {
      PermissionStatus perm = await Permission.storage.request();
      if (!perm.isGranted) {
        _log('Permission.storage.request(): $perm');
      }
    }
    _service = Service(
      start: false,
      newVerbosityLevel: 3,
      tdlibParameters: {
        // 'use_test_dc': true,
        'api_id': GlobalConfiguration().getValue<int>("telegram_api_id"),
        'api_hash': GlobalConfiguration().getValue<String>("telegram_api_hash"),
        'device_model': 'Unknown',
        'database_directory': appDir.path,
        'files_directory': tempDir.path,
        'enable_storage_optimizer': true,
      },
      beforeSend: _logWapper('beforeSend'),
      afterReceive: _afterReceive,
      beforeExecute: _logWapper('beforeExecute'),
      afterExecute: _logWapper('afterExecute'),
      onReceiveError: _logWapper('onReceiveError', (e) {
        // debugger(when: true);
      }),
    );
  }

  bool get isRunning => _service == null ? false : _service!.isRunning;
  start() async {
    if (!_service!.isRunning) {
      await _service?.start();
    }
  }

  stop() async {
    if (_service!.isRunning) {
      await _service?.stop();
    }
  }

  Function(dynamic) _logWapper(String key, [void Function(dynamic obj)? fn]) {
    return LogService.build('TelegramService:$key', fn);
  }

  _afterReceive(Map<String, dynamic> event) {
    switch (event['@type']) {
      case 'updateAuthorizationState':
        _logWapper("_afterReceive")(event);
        _handleAuth(event['authorization_state']);
        break;
    }
  }

  _handleAuth(Map<String, dynamic> state) {
    AppRouter appRouter = GetIt.I<AppRouter>();
    PageRouteInfo info;
    switch (state['@type']) {
      case 'authorizationStateWaitTdlibParameters':
      case 'authorizationStateWaitEncryptionKey':
      case 'authorizationStateWaitPassword':
      case 'authorizationStateWaitOtherDeviceConfirmation':
      case 'authorizationStateWaitRegistration':
        return;
      case 'authorizationStateWaitPhoneNumber':
        info = LoginPageRoute();
        appRouter.popAndPush(info);
        break;
      case 'authorizationStateWaitCode':
        info = AuthCodePageRoute();
        appRouter.push(info);
        break;
      case 'authorizationStateReady':
        info = ChatListPageRoute();
        appRouter.pushAndPopUntil(info, predicate: (route) {
          return true;
        });
        break;
      case 'authorizationStateLoggingOut':
      case 'authorizationStateClosing':
        return;
      case 'authorizationStateClosed':
        info = SplashPageRoute();
        appRouter.pushAndPopUntil(info, predicate: (route) {
          return true;
        });
        break;
      default:
        return;
    }
    // GetIt.I<AppRouter>().popAndPush(LoginPageRoute());
  }

  Future setAuthenticationPhoneNumber(String phoneNumber) async {
    await _service?.sendSync({
      '@type': 'setAuthenticationPhoneNumber',
      'phone_number': phoneNumber,
      'settings': {
        'allow_flash_call': false,
        'is_current_phone_number': false,
        'allow_sms_retriever_api': false,
      }
    });
  }

  Future checkAuthenticationCode(String code) async {
    await _service
        ?.sendSync({'@type': 'checkAuthenticationCode', 'code': code});
  }

  Future checkAuthenticationPassword(String password) async {
    await _service?.sendSync(
        {'@type': 'checkAuthenticationPassword', 'password': password});
  }

  Future logOut() async {
    await _service?.sendSync({'@type': 'logOut'});
  }
}
