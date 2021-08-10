import 'dart:async';
import 'dart:convert';
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
import 'package:collection/collection.dart';

import 'app_router.gr.dart';
import 'get_it.dart' show LogService;

class TelegramService extends ChangeNotifier {
  Service? _service;
  Function(dynamic s) _log = LogService.build('TelegramService');

  late StreamController<int> _chatController;

  List<Chat> chats = [];
  User? me;
  List<User> users = [];
  List<UpdateChatPosition> chatPositions = [];
  List<File> files = [];

  TelegramService() {
    _chatController = StreamController.broadcast();
    _init();
  }

  int _value = 0;

  Stream<int> chatsStream() {
    return _chatController.stream;
  }

  _refresh() {
    chats.sort((a, b) {
      int positionA = a.positions?.firstOrNull?.order ?? 0;
      int positionB = b.positions?.firstOrNull?.order ?? 0;
      return positionB.compareTo(positionA);
    });
    _chatController.add(_value++);
  }

  _init() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    Directory tempDir = await getTemporaryDirectory();
    print('dabaseDirectory: $appDir');
    print('fielsDirectory: $tempDir');
    // if (Platform.isAndroid || Platform.isIOS) {
    //   PermissionStatus perm = await Permission.storage.request();
    //   if (!perm.isGranted) {
    //     _log('Permission.storage.request(): $perm');
    //   }
    // }
    _service = Service(
      start: false,
      newVerbosityLevel: 1,

      /// encryptionKey's length should be 20?
      encryptionKey: 'wombatkoalapixelgram',
      tdlibParameters: TdlibParameters(
              apiId: GlobalConfiguration().getValue<int>("telegram_api_id"),
              apiHash:
                  GlobalConfiguration().getValue<String>("telegram_api_hash"),
              databaseDirectory: appDir.path,
              filesDirectory: tempDir.path + '/pixelegram',
              enableStorageOptimizer: true,
              useChatInfoDatabase: true,
              useMessageDatabase: true,
              useFileDatabase: true,
              useTestDc: false,
              useSecretChats: true,
              ignoreFileNames: true,
              systemLanguageCode: 'EN',
              applicationVersion: '0.0.1',
              deviceModel: 'Unknown',
              systemVersion: 'Unknown')
          .toJson()
            ..removeNull(),
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
    _logWapper("_afterReceive")(event);
    TdObject? object = convertToObject(jsonEncode(event));
    if (object == null) {
      return;
    }
    if (object is UpdateAuthorizationState) {
      _handleAuth(object.authorizationState);
    } else if (object is UpdateNewChat) {
      chats = [object.chat!, ...chats];
      _refresh();
    } else if (object is UpdateOption) {
      if (me == null &&
          object.name == 'my_id' &&
          object.value is OptionValueInteger) {
        me = User(id: (object.value as OptionValueInteger).value!);
      }
    } else if (object is UpdateUnreadMessageCount) {
      /// unread message count
    } else if (object is UpdateChatReadInbox) {
      /// incoming message unread count
      chats.firstWhereOrNull((element) => element.id == object.chatId)
        ?..unreadCount = object.unreadCount
        ..lastReadInboxMessageId = object.lastReadInboxMessageId;
      _refresh();
    } else if (object is UpdateNewMessage) {
    } else if (object is UpdateChatLastMessage) {
      Chat chat = chats.firstWhere((chat) => chat.id == object.chatId!)
        ..lastMessage = object.lastMessage
        ..positions = object.positions;
      chats = [chat, ...chats..remove(chat)];
      _refresh();
    } else if (object is UpdateChatPosition) {
      chats.firstWhere((element) => element.id == object.chatId!).positions = [
        object.position!
      ];
      _refresh();
    } else if (object is Chats) {
      print('会话列表信息: ${object.toJson()}');
    } else if (object is Chat) {
      // _chatController.add(object);
    } else if (object is TdError) {
      print("錯誤: ${object.toJson()}");
    } else if (object is UpdateFile) {
      print('文件更新: ${object.toJson()}');
      if (object.file?.local?.isDownloadingCompleted ?? false) {
        files
          ..removeWhere((element) => element.id == object.file!.id)
          ..add(object.file!);
        _refresh();
      }
    } else if (object is File) {
      print('本地文件: ${object.toJson()}');
      files
        ..removeWhere((element) => element.id == object.id)
        ..add(object);
      _refresh();
    } else if (object is UpdateUser) {
      User? newUser = object.user;
      if (newUser == null) {
        return;
      }
      if (newUser.id == me?.id) {
        me = newUser;
      }
      users
        ..removeWhere((user) => user.id == newUser.id)
        ..add(newUser);
      print('用户人数:${users.length}');
      _refresh();
    }
  }

  _handleAuth(AuthorizationState? state) {
    if (state == null) {
      return;
    }
    AppRouter appRouter = GetIt.I<AppRouter>();
    PageRouteInfo info;

    switch (state.getConstructor()) {
      case AuthorizationStateWaitTdlibParameters.CONSTRUCTOR:
      case AuthorizationStateWaitEncryptionKey.CONSTRUCTOR:
      case AuthorizationStateWaitPassword.CONSTRUCTOR:
      case AuthorizationStateWaitOtherDeviceConfirmation.CONSTRUCTOR:
      case AuthorizationStateWaitRegistration.CONSTRUCTOR:
        return;
      case AuthorizationStateWaitPhoneNumber.CONSTRUCTOR:
        info = LoginPageRoute();
        appRouter.popAndPush(info);
        break;
      case AuthorizationStateWaitCode.CONSTRUCTOR:
        info = AuthCodePageRoute();
        appRouter.push(info);
        break;
      case AuthorizationStateReady.CONSTRUCTOR:
        info = ChatListPageRoute();
        appRouter.pushAndPopUntil(info, predicate: (route) {
          return true;
        });
        break;
      case AuthorizationStateLoggingOut.CONSTRUCTOR:
      case AuthorizationStateClosing.CONSTRUCTOR:
        return;
      case AuthorizationStateClosed.CONSTRUCTOR:
        info = SplashPageRoute();
        appRouter.pushAndPopUntil(info, predicate: (route) {
          return true;
        });
        break;
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

  Future getChats() async {
    final int64MaxValue = 9223372036854775807;
    final int32MaxValue = 1 << 31 - 1;

    _send(GetChats(
        chatList: ChatListMain(),
        offsetOrder: int64MaxValue,
        offsetChatId: 0,
        limit: int32MaxValue));
  }

  Future getUser(int userId) async {
    await _send(GetUser(userId: userId));
  }

  Future getFile(int? fileId) async {
    if (fileId == null) return;
    await _sendSync(GetFile(fileId: fileId));
  }

  String? getLocalFile(int? fileId) {
    if (fileId == null) {
      return null;
    }
    File? file = files.firstWhereOrNull((element) => element.id == fileId);
    if (file == null) {
      downloadFile(fileId);
      return null;
    }
    return file.local!.path!;
  }

  Future downloadFile(int? fileId) async {
    print('fileId: $fileId');
    if (fileId == null) return;
    await _send(DownloadFile(fileId: fileId));
  }

  Future logOut() async {
    await _sendSync(LogOut());
  }

  _execute(TdFunction event) async {
    await _service?.execute(event.toJson()..removeNull());
  }

  _sendSync(TdFunction event) async {
    await _service?.sendSync(event.toJson()..removeNull());
  }

  _send(TdFunction event) async {
    await _service?.send(event.toJson()..removeNull());
  }
}

extension MapX on Map<String, dynamic> {
  Map<String, dynamic> removeNull() {
    return this..removeWhere((key, value) => value == null);
  }
}
