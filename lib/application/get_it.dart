import 'package:get_it/get_it.dart' show GetIt;
import 'package:pixelegram/application/app_router.gr.dart';

import 'telegram_service.dart' show TelegramService;

export 'log_service.dart' show LogService;
export 'telegram_service.dart' show TelegramService;

void registerAll() {
  GetIt.instance
    ..registerSingleton(TelegramService())
    ..registerLazySingleton(() => AppRouter());
}
