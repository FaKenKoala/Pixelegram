import 'package:auto_route/auto_route.dart';
import 'package:pixelegram/presentation/home/chat_list_page.dart';
import 'package:pixelegram/presentation/home/chat_page.dart';
import 'package:pixelegram/presentation/login/auth_code_page.dart';
import 'package:pixelegram/presentation/login/login_page.dart';
import 'package:pixelegram/presentation/splash/splash_page.dart';

@MaterialAutoRouter(routes: [
  AutoRoute(page: SplashPage, initial: true),
  AutoRoute(page: LoginPage),
  AutoRoute(page: AuthCodePage),
  AutoRoute(page: ChatListPage),
  AutoRoute(page: ChatPage),
])
class $AppRouter {}
