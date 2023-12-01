import 'package:get_it/get_it.dart';
import 'package:jasper_wt/data/repositories/user_repository.dart';

import 'clients/firestore_service.dart';
import 'repositories/authentication_repository.dart';
import 'repositories/log_repository.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  locator.registerLazySingleton(() => AuthenticationRepository());
  locator.registerLazySingleton(() => LogRepository());
  locator.registerFactory(() => FirestoreService());
  locator.registerLazySingleton(() => UserRepository());
}
