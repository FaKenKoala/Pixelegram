import 'dart:async';
import 'dart:io' show Directory, Platform;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:get_it/get_it.dart' show GetIt;
import 'package:global_configuration/global_configuration.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory, getTemporaryDirectory;

import 'package:libtdjson/libtdjson.dart' show Service;
import 'package:pixelegram/infrastructure/tdapi.dart';

import 'app_router.gr.dart';
import 'get_it.dart' show LogService;

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
      tdlibParameters: TdlibParameters(
        apiId: GlobalConfiguration().getValue<int>("telegram_api_id"),
        apiHash: GlobalConfiguration().getValue<String>("telegram_api_hash"),
        deviceModel: 'Unknown',
        databaseDirectory: appDir.path,
        filesDirectory: tempDir.path,
        enableStorageOptimizer: true,
      ).toJson(),
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
      await setLogVerbosityLevel();
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
    // _logWapper("_afterReceive")(event);

    switch (event['@type']) {
      case 'updateAuthorizationState':
        _handleAuth(event['authorization_state']);
        break;
      case 'chats':
        print('会话列表信息: $event');
        break;
      case 'chat':
        break;
      case 'error':
        print("錯誤: $event");
        break;
      default:
        return;
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
  }

  Future setAuthenticationPhoneNumber(String phoneNumber) async {
    await _sendSync(SetAuthenticationPhoneNumber(
        phoneNumber: phoneNumber,
        settings: PhoneNumberAuthenticationSettings(
          allowFlashCall: false,
          isCurrentPhoneNumber: false,
          allowSmsRetrieverApi: false,
        )));
  }

  Future checkAuthenticationCode(String code) async {
    await _sendSync(CheckAuthenticationCode(code: code));
  }

  Future checkAuthenticationPassword(String password) async {
    await _sendSync(CheckAuthenticationPassword(password: password));
  }

  Future setLogVerbosityLevel() async {
    _execute(SetLogVerbosityLevel(newVerbosityLevel: 1));
  }

  Future getChats() async {
    final int64MaxValue = 9223372036854775807;
    final int32MaxValue = 1 << 31 - 1;

    _send(GetChats(
        chatList: ChatListMain(),
        offsetOrder: int64MaxValue,
        offsetChatId: 0,
        limit: int32MaxValue));
  }

  Future logOut() async {
    await _sendSync(LogOut());
  }

  _execute(TdFunction event) async {
    await _service?.execute(event.toJson());
  }

  _sendSync(TdFunction event) async {
    await _service?.sendSync(event.toJson());
  }

  _send(TdFunction event) async {
    await _service?.send(event.toJson());
  }
}
