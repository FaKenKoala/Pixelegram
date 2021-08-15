import 'package:pixelegram/application/router/router.dart';
import 'package:pixelegram/infrastructure/get_it/main.dart';

void registerDependencies() {
  configureDependencies();
  getIt
    ..registerLazySingleton(() => AppRouter());
}
