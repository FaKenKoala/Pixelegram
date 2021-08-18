import 'dart:async';
import 'dart:convert';
import 'dart:io' show Directory, Platform;

import 'package:auto_route/auto_route.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory, getTemporaryDirectory;

import 'package:libtdjson/libtdjson.dart' show Service;
import 'package:pixelegram/application/router/router.dart';
import 'package:pixelegram/domain/service/i_telegram_service.dart';
import 'package:pixelegram/domain/model/tdapi.dart';
import 'package:collection/collection.dart';
import 'package:pixelegram/infrastructure/get_it/main.dart';

import 'log_service.dart';
import 'package:rxdart/rxdart.dart';

@Singleton(as: ITelegramService)
class TelegramService implements ITelegramService {
  Service? _service;
  late BehaviorSubject<int> _chatController;
  List<Chat> chats = [];
  User? me;
  List<User> users = [];
  List<File> files = [];

  CurrentChatController? currentChatController;

  TelegramService() {
    _chatController = BehaviorSubject.seeded(0);
    _init();
  }

  Stream<int> chatsStream() {
    return _chatController.stream;
  }

  Stream<Message> messageStream(int chatId) {
    if (currentChatController == null ||
        currentChatController!.chatId != chatId) {
      currentChatController?.dispose();
      currentChatController = CurrentChatController(chatId: chatId);
    }
    return currentChatController!.controller.stream;
  }

  StreamController? _getMessageController(int? chatId) {
    if (chatId != null && currentChatController?.chatId == chatId) {
      return currentChatController!.controller;
    }
    return null;
  }

  _refreshLastMessage() {
    chats.sort(chatComparator);
    _chatController.add(_chatController.value + 1);
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
      newVerbosityLevel: 0, //1,
      /// encryptionKey's length should be 20?
      encryptionKey: GlobalConfiguration().getValue<String>("encryption_key"),
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
      beforeSend: _logWrapper('beforeSend'),
      afterReceive: _afterReceive,
      beforeExecute: _logWrapper('beforeExecute'),
      afterExecute: _logWrapper('afterExecute'),
      onReceiveError: _logWrapper('onReceiveError', (e) {
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

  Function(dynamic) _logWrapper(String key, [void Function(dynamic obj)? fn]) {
    return LogService.build('TelegramService:$key', fn);
  }

  _afterReceive(Map<String, dynamic> event) {
    _logWrapper("_afterReceive")(event);
    TdObject? object = convertToObject(jsonEncode(event));
    if (object == null) {
      return;
    }

    switch (object.getConstructor()) {
      case UpdateAuthorizationState.CONSTRUCTOR:
        UpdateAuthorizationState tdObject = object as UpdateAuthorizationState;
        _handleAuth(tdObject.authorizationState);
        break;
      case UpdateNewChat.CONSTRUCTOR:
        UpdateNewChat tdObject = object as UpdateNewChat;
        chats = [tdObject.chat!, ...chats];
        _refreshLastMessage();
        break;
      case UpdateOption.CONSTRUCTOR:
        UpdateOption tdObject = object as UpdateOption;
        if (me == null &&
            tdObject.name == 'my_id' &&
            tdObject.value is OptionValueInteger) {
          me = User(id: (tdObject.value as OptionValueInteger).value!);
        }
        break;
      case UpdateUnreadMessageCount.CONSTRUCTOR:
        UpdateUnreadMessageCount tdObject = object as UpdateUnreadMessageCount;

        /// unread message count
        break;
      case UpdateChatReadInbox.CONSTRUCTOR:
        UpdateChatReadInbox tdObject = object as UpdateChatReadInbox;

        /// incoming message unread count
        chats.firstWhereOrNull((element) => element.id == tdObject.chatId)
          ?..unreadCount = tdObject.unreadCount
          ..lastReadInboxMessageId = tdObject.lastReadInboxMessageId;
        _refreshLastMessage();
        break;
      case UpdateNewMessage.CONSTRUCTOR:
        UpdateNewMessage tdObject = object as UpdateNewMessage;
        _getMessageController(tdObject.message?.chatId)?.add(tdObject.message!);
        break;
      case UpdateChatLastMessage.CONSTRUCTOR:
        UpdateChatLastMessage tdObject = object as UpdateChatLastMessage;
        Chat chat = chats.firstWhere((chat) => chat.id == tdObject.chatId!)
          ..lastMessage = tdObject.lastMessage
          ..positions = tdObject.positions;
        chats = [chat, ...chats..remove(chat)];
        _refreshLastMessage();
        break;
      case UpdateChatPosition.CONSTRUCTOR:
        UpdateChatPosition tdObject = object as UpdateChatPosition;
        chats
            .firstWhere((element) => element.id == tdObject.chatId!)
            .positions = [tdObject.position!];
        _refreshLastMessage();
        break;
      case Chats.CONSTRUCTOR:
        Chats tdObject = object as Chats;
        print('会话列表信息: ${tdObject.toJson()}');
        break;
      case Chat.CONSTRUCTOR:
        Chat tdObject = object as Chat;
        // _chatController.add(object);
        break;
      case TdError.CONSTRUCTOR:
        TdError tdObject = object as TdError;
        print("錯誤: ${tdObject.toJson()}");
        break;
      case UpdateFile.CONSTRUCTOR:
        UpdateFile tdObject = object as UpdateFile;
        print('文件更新: ${tdObject.toJson()}');
        if (tdObject.file?.local?.isDownloadingCompleted ?? false) {
          files
            ..removeWhere((element) => element.id == tdObject.file!.id)
            ..add(tdObject.file!);
          _refreshLastMessage();
        }
        break;
      case File.CONSTRUCTOR:
        File tdObject = object as File;
        print('本地文件: ${tdObject.toJson()}');
        files
          ..removeWhere((element) => element.id == tdObject.id)
          ..add(object);
        _refreshLastMessage();
        break;
      case UpdateUser.CONSTRUCTOR:
        UpdateUser tdObject = object as UpdateUser;
        User? newUser = tdObject.user;
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
        _refreshLastMessage();
        break;
    }
  }

  _handleAuth(AuthorizationState? state) {
    if (state == null) {
      return;
    }
    AppRouter appRouter = getIt<AppRouter>();
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

  @override
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

  String? getUsername(int? userId) {
    if (userId == null) {
      return null;
    }
    return users.firstWhereOrNull((element) => element.id == userId)?.firstName;
  }

  String? getUserAvatar(int? userId) {
    if (userId == null) {
      return null;
    }

    int? fileId = users
        .firstWhereOrNull((element) => element.id == userId)
        ?.profilePhoto
        ?.small
        ?.id;
    return getLocalFile(fileId);
  }

  Future downloadFile(int? fileId) async {
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

class CurrentChatController {
  int chatId;
  late PublishSubject<Message> controller;

  CurrentChatController({required this.chatId}) {
    controller = PublishSubject();
  }

  void dispose() {
    controller.close();
  }
}
