import 'package:pixelegram/application/app_router.gr.dart';
import 'package:pixelegram/infrastructure/get_it/main.dart';

void registerAll() {
  configureDependencies();
  getIt
    ..registerLazySingleton(() => AppRouter());
}
