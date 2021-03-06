import 'package:auto_route/auto_route.dart';
import 'package:pixelegram/presentation/chat_list/chat_list_page.dart';
import 'package:pixelegram/presentation/chat/chat_page.dart';
import 'package:pixelegram/presentation/login/auth_code_page.dart';
import 'package:pixelegram/presentation/login/login_page.dart';
import 'package:pixelegram/presentation/splash/splash_page.dart';
import 'package:pixelegram/presentation/video_play/video_play_page.dart';

@MaterialAutoRouter(preferRelativeImports: false, routes: [
  AutoRoute(page: SplashPage, initial: true),
  AutoRoute(page: LoginPage),
  AutoRoute(page: AuthCodePage),
  AutoRoute(page: ChatListPage),
  AutoRoute(page: ChatPage),
  AutoRoute(page: VideoPlayPage),
])
class $AppRouter {}
