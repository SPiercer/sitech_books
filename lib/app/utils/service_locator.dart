import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sitech_books/app/shared/constants.dart' as api;
import 'package:sitech_books/app/utils/data_source.dart';
import 'package:sitech_books/app/utils/local_cache.dart';
import 'package:sitech_books/app/utils/repository.dart';

final locator = GetIt.instance;

Future<void> initializeServices() async {
  final baseOptions = BaseOptions(
    baseUrl: api.endpoint, // [/api/v1]
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  locator.registerLazySingleton<Dio>(() => Dio(baseOptions));

  final prefs = await SharedPreferences.getInstance();

  locator.registerSingleton<SharedPreferences>(prefs);

  locator.registerSingleton<LocalCache>(LocalCacheImpl(prefs));
  locator.registerLazySingleton<Repository>(() => Repository());
  locator
      .registerLazySingleton<RemoteSource>(() => RemoteSource(locator<Dio>()));
  locator.registerLazySingleton<LocalSource>(() => LocalSource(locator<Dio>()));
}
