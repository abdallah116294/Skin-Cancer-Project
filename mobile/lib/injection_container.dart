import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile/core/network/ai_consumer.dart';
import 'package:mobile/core/network/api_consumer.dart';
import 'package:mobile/core/network/api_iterceptors.dart';
import 'package:mobile/core/network/dio_consumer.dart';
import 'package:mobile/features/AI_scan/cubit/ai_perediction_cubit.dart';
import 'package:mobile/features/AI_scan/data/ai_repo.dart';
import 'package:mobile/features/AI_scan/data/ai_repo_impl.dart';
import 'package:mobile/features/Auth/cubit/auth_cubit.dart';
import 'package:mobile/features/Auth/data/repository/auth_repo.dart';
import 'package:mobile/features/Auth/data/repository/auth_repo_impl.dart';
import 'package:mobile/features/clinic/cubit/clinic_cubit.dart';
import 'package:mobile/features/clinic/data/repo/clinic_repo.dart';
import 'package:mobile/features/clinic/data/repo/clinic_repo_impl.dart';
import 'package:mobile/features/explore/cubit/patient_cubit_cubit.dart';
import 'package:mobile/features/explore/data/repo/patient_clinic_repo.dart';
import 'package:mobile/features/explore/data/repo/patient_clinic_repo_impl.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //!Auth
  //cubit
  sl.registerFactory(() => AuthCubit(authRepo: sl()));
  //repo
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(apiConsumer: sl()));
  //!Clinic
  //cubit
  sl.registerFactory(
      () => ClinicCubit(clinicRepo: sl(), patientClinicRepo: sl()));
  //repo
  sl.registerLazySingleton<ClinicRepo>(() => ClinicRepoImpl(apiConsumer: sl()));
  //!Patient
  sl.registerFactory(() => PatientClinicCubit(patientClinicRepo: sl()));
  sl.registerLazySingleton<PatientClinicRepo>(
      () => PatinetClinicRepoImpl(apiConsumer: sl()));
  //!Ai
  sl.registerFactory(() => AiPeredictionCubit(aiRepo: sl()));
  //repo
  sl.registerLazySingleton<AIRepo>(() => AIRepoImpl());
  //!core
  sl.registerLazySingleton<ApiConsumer>(() => DioCosumer(client: sl()));
  sl.registerLazySingleton(() => DioHelper());
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
