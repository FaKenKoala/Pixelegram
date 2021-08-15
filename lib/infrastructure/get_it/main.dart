import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'main.config.dart';

final getIt = GetIt.I;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: false,
  asExtension: false,
)
void configureDependencies()=> $initGetIt(getIt);
