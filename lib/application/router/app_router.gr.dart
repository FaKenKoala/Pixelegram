// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;
import 'package:model_tdapi/model_tdapi.dart' as _i9;
import 'package:pixelegram/presentation/chat/chat_page.dart' as _i7;
import 'package:pixelegram/presentation/chat_list/chat_list_page.dart' as _i6;
import 'package:pixelegram/presentation/login/auth_code_page.dart' as _i5;
import 'package:pixelegram/presentation/login/login_page.dart' as _i4;
import 'package:pixelegram/presentation/splash/splash_page.dart' as _i3;
import 'package:pixelegram/presentation/video_play/video_play_page.dart' as _i8;

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
        builder: (data) {
          final args = data.argsAs<ChatPageRouteArgs>();
          return _i7.ChatPage(key: args.key, chat: args.chat);
        }),
    VideoPlayPageRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<VideoPlayPageRouteArgs>();
          return _i8.VideoPlayPage(
              key: args.key,
              videoFile: args.videoFile,
              aspectRatio: args.aspectRatio);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashPageRoute.name, path: '/'),
        _i1.RouteConfig(LoginPageRoute.name, path: '/login-page'),
        _i1.RouteConfig(AuthCodePageRoute.name, path: '/auth-code-page'),
        _i1.RouteConfig(ChatListPageRoute.name, path: '/chat-list-page'),
        _i1.RouteConfig(ChatPageRoute.name, path: '/chat-page'),
        _i1.RouteConfig(VideoPlayPageRoute.name, path: '/video-play-page')
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

class ChatPageRoute extends _i1.PageRouteInfo<ChatPageRouteArgs> {
  ChatPageRoute({_i2.Key? key, required _i9.Chat chat})
      : super(name,
            path: '/chat-page', args: ChatPageRouteArgs(key: key, chat: chat));

  static const String name = 'ChatPageRoute';
}

class ChatPageRouteArgs {
  const ChatPageRouteArgs({this.key, required this.chat});

  final _i2.Key? key;

  final _i9.Chat chat;
}

class VideoPlayPageRoute extends _i1.PageRouteInfo<VideoPlayPageRouteArgs> {
  VideoPlayPageRoute(
      {_i2.Key? key, required String videoFile, double? aspectRatio})
      : super(name,
            path: '/video-play-page',
            args: VideoPlayPageRouteArgs(
                key: key, videoFile: videoFile, aspectRatio: aspectRatio));

  static const String name = 'VideoPlayPageRoute';
}

class VideoPlayPageRouteArgs {
  const VideoPlayPageRouteArgs(
      {this.key, required this.videoFile, this.aspectRatio});

  final _i2.Key? key;

  final String videoFile;

  final double? aspectRatio;
}
