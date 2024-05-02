import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile/core/api/dio_helper.dart';
import 'package:mobile/features/Auth/data/remote_data/firebase_remote_data_source_impl.dart';
import 'package:mobile/features/Auth/data/remote_data/firebase_remote_data_sourec.dart';
import 'package:mobile/features/Auth/data/repository/auth_repo_impl.dart';
import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';
import 'package:mobile/features/Auth/domain/usecase/add_appointment_usecsae.dart';
import 'package:mobile/features/Auth/domain/usecase/add_new_clinic.dart';
import 'package:mobile/features/Auth/domain/usecase/add_prescription_uscase.dart';
import 'package:mobile/features/Auth/domain/usecase/add_result_usecase.dart';
import 'package:mobile/features/Auth/domain/usecase/add_selected_clinic_usecase.dart';
import 'package:mobile/features/Auth/domain/usecase/get_ai_results_usecase.dart';
import 'package:mobile/features/Auth/domain/usecase/get_clinic_uscase.dart';
import 'package:mobile/features/Auth/domain/usecase/get_current_UID.dart';
import 'package:mobile/features/Auth/domain/usecase/get_current_doctor.dart';
import 'package:mobile/features/Auth/domain/usecase/get_current_patient.dart';
import 'package:mobile/features/Auth/domain/usecase/get_doctor_usecase.dart';
import 'package:mobile/features/Auth/domain/usecase/get_selected_clinic_usecase.dart';
import 'package:mobile/features/Auth/domain/usecase/is_sign_usecase.dart';
import 'package:mobile/features/Auth/domain/usecase/sigin_doctor_usecase.dart';
import 'package:mobile/features/Auth/domain/usecase/signin_patient_use_case.dart';
import 'package:mobile/features/Auth/domain/usecase/signup_doctor_usecase.dart';
import 'package:mobile/features/Auth/domain/usecase/signup_patient_uscase.dart';
import 'package:mobile/features/Auth/domain/usecase/user_signout.dart';
import 'package:mobile/features/Auth/presentation/auth_cubit.dart';
import 'package:mobile/features/home/presentation/cubit/home_cubit.dart';
import 'package:mobile/features/search/data/datasource/search_remote_data_source.dart';
import 'package:mobile/features/search/data/repository/search_repo_impl.dart';
import 'package:mobile/features/search/domain/repository/search_repository.dart';
import 'package:mobile/features/search/domain/usecase/search_usecase.dart';
import 'package:mobile/features/search/presentation/cubit/search_cubit.dart';

import 'features/Auth/domain/usecase/get_appointment_uscase.dart';
import 'features/Auth/domain/usecase/get_specific_doctor_usecase.dart';
import 'features/Auth/domain/usecase/get_specific_patient_uscase.dart';
import 'features/Auth/domain/usecase/reset_password_usecase.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //!Features
  //!Auth
  //bloc
  sl.registerFactory<AuthCubit>(() => AuthCubit(
      signUpDoctorUseCase: sl(),
      sigInDoctorUseCase: sl(),
      restPasswordUseCase: sl(),
      getCurrentUID: sl(),
      currentPatientUseCase: sl(),
      currentDoctor: sl(),
      addNewClinicUseCase: sl(),
      signUpPatientUseCase: sl(),
      signInPatientUseCase: sl(),
      getSpecificPatientUseCase: sl(),
      getSpecificDoctorByUid: sl(),
      signOutUseCase: sl()));
  sl.registerFactory<HomeCubit>(() => HomeCubit(
      doctorUseCase: sl(),
      getClinicUseCase: sl(),
      selectedClinicUseCase: sl(),
      addAppointmentUseCase: sl(),
      getCurrentUID: sl(),
      getSpecificPatientUseCase: sl(),
      getSpecificDoctorByUid: sl(),
      getAppointmentUseCse: sl(),
      addResult: sl(),
      aiResultUseCase: sl(),
      getSelectedClinicUseCase: sl(),
      addPrescriptionUseCase: sl()));
  //Use Case
  sl.registerLazySingleton<SigInDoctorUseCase>(
      () => SigInDoctorUseCase(repo: sl()));
  sl.registerLazySingleton<SignUpDoctorUseCase>(
      () => SignUpDoctorUseCase(repo: sl()));
  sl.registerLazySingleton<IsSigInUseCase>(() => IsSigInUseCase(repo: sl()));
  sl.registerLazySingleton<GetCurrentUID>(() => GetCurrentUID(repo: sl()));
  sl.registerLazySingleton<RestPasswordUseCase>(
      () => RestPasswordUseCase(repo: sl()));
  sl.registerLazySingleton<GetCurrentPatientUseCase>(
      () => GetCurrentPatientUseCase(repo: sl()));
  sl.registerLazySingleton<GetCurrentDoctor>(
      () => GetCurrentDoctor(repo: sl()));
  sl.registerLazySingleton<AddNewClinicUseCase>(
      () => AddNewClinicUseCase(repo: sl()));
  sl.registerLazySingleton<SignInPatientUseCase>(
      () => SignInPatientUseCase(repo: sl()));
  sl.registerLazySingleton<SignUpPatientUseCase>(
      () => SignUpPatientUseCase(repo: sl()));
  sl.registerLazySingleton<GetDoctorUseCase>(
      () => GetDoctorUseCase(repo: sl()));
  sl.registerLazySingleton<GetSpecificPatientUseCase>(
      () => GetSpecificPatientUseCase(repo: sl()));
  sl.registerLazySingleton<GetClinicUseCase>(
      () => GetClinicUseCase(repo: sl()));
  sl.registerLazySingleton(() => AddSelectedClinicUseCase(repo: sl()));
  sl.registerLazySingleton<AddAppointmentUseCase>(
      () => AddAppointmentUseCase(repo: sl()));
  sl.registerLazySingleton<GetSpecificDoctorByUid>(
      () => GetSpecificDoctorByUid(repo: sl()));
  sl.registerLazySingleton<GetAppointmentUseCse>(
      () => GetAppointmentUseCse(repo: sl()));
  sl.registerLazySingleton<AddResult>(() => AddResult(repo: sl()));
  sl.registerLazySingleton<UserSignOutUseCase>(
      () => UserSignOutUseCase(repo: sl()));
  sl.registerLazySingleton<GetAIResultUseCase>(
      () => GetAIResultUseCase(repo: sl()));
  sl.registerLazySingleton<GetSelectedClinicUseCase>(
      () => GetSelectedClinicUseCase(repo: sl()));
  sl.registerLazySingleton<AddPrescriptionUseCase>(() => AddPrescriptionUseCase(repo: sl()));
  //repository
  sl.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(
          auth: sl(), firestore: sl(), firebaseStorage: sl()));
  //!search
  //Bloc
  sl.registerFactory(() => SearchCubit(searchUseCase: sl()));
  //use case
  sl.registerLazySingleton(() => SearchUseCase(searchRepository: sl()));
  //repository
  sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(searchRemoteDataSource: sl()));
  //data source
  sl.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(dioHepler: sl()));
  //dio helper
  sl.registerLazySingleton(() => DioHepler(sl()));
  sl.registerLazySingleton(() => Dio());
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final fireStorage = FirebaseStorage.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
  sl.registerLazySingleton(() => fireStorage);
}
