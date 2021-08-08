// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../presentation/home/chat_list_page.dart' as _i6;
import '../presentation/home/chat_page.dart' as _i7;
import '../presentation/login/auth_code_page.dart' as _i5;
import '../presentation/login/login_page.dart' as _i4;
import '../presentation/splash/splash_page.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashPageRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i3.SplashPage();
        }),
    LoginPageRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i4.LoginPage();
        }),
    AuthCodePageRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i5.AuthCodePage();
        }),
    ChatListPageRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i6.ChatListPage();
        }),
    ChatPageRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i7.ChatPage();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashPageRoute.name, path: '/'),
        _i1.RouteConfig(LoginPageRoute.name, path: '/login-page'),
        _i1.RouteConfig(AuthCodePageRoute.name, path: '/auth-code-page'),
        _i1.RouteConfig(ChatListPageRoute.name, path: '/chat-list-page'),
        _i1.RouteConfig(ChatPageRoute.name, path: '/chat-page')
      ];
}

class SplashPageRoute extends _i1.PageRouteInfo {
  const SplashPageRoute() : super(name, path: '/');

  static const String name = 'SplashPageRoute';
}

class LoginPageRoute extends _i1.PageRouteInfo {
  const LoginPageRoute() : super(name, path: '/login-page');

  static const String name = 'LoginPageRoute';
}

class AuthCodePageRoute extends _i1.PageRouteInfo {
  const AuthCodePageRoute() : super(name, path: '/auth-code-page');

  static const String name = 'AuthCodePageRoute';
}

class ChatListPageRoute extends _i1.PageRouteInfo {
  const ChatListPageRoute() : super(name, path: '/chat-list-page');

  static const String name = 'ChatListPageRoute';
}

class ChatPageRoute extends _i1.PageRouteInfo {
  const ChatPageRoute() : super(name, path: '/chat-page');

  static const String name = 'ChatPageRoute';
}
