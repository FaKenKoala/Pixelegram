import 'package:pixelegram/domain/model/tdapi.dart';

abstract class ITelegramService {
  User? get me;
  List<User> get users;
  List<Chat> get chats;
  void start();

  String? getLocalFile(int? fileId);
  String? getAnimationGif(int? fileId);
  Future getChats();
  Future checkAuthenticationCode(String code);
  Future checkAuthenticationPassword(String password);
  Future setAuthenticationPhoneNumber(String phoneNumber);

  Stream<int> chatsStream();
  Stream<Message> messageStream(int chatId);
  String? getUsername(int? userId);
  String? getUserAvatar(int? userId);
  Future getChatHistory({required int chatId, int fromMessageId = 0});
  Stream<List<Message>> historyStream();
}
