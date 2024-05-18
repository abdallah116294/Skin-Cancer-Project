import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile/core/network/api_consumer.dart';
import 'package:mobile/core/network/api_iterceptors.dart';
import 'package:mobile/core/network/dio_consumer.dart';
import 'package:mobile/features/Auth/cubit/auth_cubit.dart';
import 'package:mobile/features/Auth/data/repository/auth_repo.dart';
import 'package:mobile/features/Auth/data/repository/auth_repo_impl.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //!Auth
  //cubit
  sl.registerFactory(() => AuthCubit(authRepo: sl()));
  //repo
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(apiConsumer: sl()));
  //!core
  sl.registerLazySingleton<ApiConsumer>(() => DioCosumer(client: sl()));

  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true));
  sl.registerLazySingleton(() => Dio());
}
