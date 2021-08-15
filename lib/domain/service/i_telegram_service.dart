import 'package:pixelegram/domain/model/tdapi.dart';

abstract class ITelegramService {
  User? get me;
  List<User> get users;
  List<Chat> get chats;
  void start();

  String? getLocalFile(int? fileId);
  Future getChats();
  Future checkAuthenticationCode(String code);
  Future checkAuthenticationPassword(String password);
  Future setAuthenticationPhoneNumber(String phoneNumber);

  Stream<int> chatsStream();
  Stream<Message> messageStream();
}
