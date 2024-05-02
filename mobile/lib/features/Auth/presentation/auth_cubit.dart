import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/Auth/domain/entities/clinc_entity.dart';
import 'package:mobile/features/Auth/domain/entities/doctor_entity.dart';
import 'package:mobile/features/Auth/domain/entities/patient_entity.dart';
import 'package:mobile/features/Auth/domain/usecase/add_new_clinic.dart';
import 'package:mobile/features/Auth/domain/usecase/get_current_UID.dart';
import 'package:mobile/features/Auth/domain/usecase/get_current_doctor.dart';
import 'package:mobile/features/Auth/domain/usecase/get_current_patient.dart';
import 'package:mobile/features/Auth/domain/usecase/sigin_doctor_usecase.dart';
import 'package:mobile/features/Auth/domain/usecase/signin_patient_use_case.dart';
import 'package:mobile/features/Auth/domain/usecase/signup_doctor_usecase.dart';
import 'package:mobile/features/Auth/domain/usecase/signup_patient_uscase.dart';
import 'package:mobile/features/Auth/domain/usecase/user_signout.dart';

import '../domain/usecase/get_specific_doctor_usecase.dart';
import '../domain/usecase/get_specific_patient_uscase.dart';
import '../domain/usecase/reset_password_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.signUpDoctorUseCase,
    required this.sigInDoctorUseCase,
    required this.restPasswordUseCase,
    required this.getCurrentUID,
    required this.currentPatientUseCase,
    required this.currentDoctor,
    required this.addNewClinicUseCase,
    required this.signUpPatientUseCase,
    required this.signInPatientUseCase,
    required this.getSpecificPatientUseCase,
    required this.getSpecificDoctorByUid,
    required this.signOutUseCase,
  }) : super(AuthInitial());
  final SignUpDoctorUseCase signUpDoctorUseCase;
  final SigInDoctorUseCase sigInDoctorUseCase;
  final RestPasswordUseCase restPasswordUseCase;
  final GetCurrentUID getCurrentUID;
  final GetCurrentPatientUseCase currentPatientUseCase;
  final GetCurrentDoctor currentDoctor;
  final AddNewClinicUseCase addNewClinicUseCase;
  final SignInPatientUseCase signInPatientUseCase;
  final SignUpPatientUseCase signUpPatientUseCase;
  final GetSpecificPatientUseCase getSpecificPatientUseCase;
  final GetSpecificDoctorByUid getSpecificDoctorByUid;
  final UserSignOutUseCase signOutUseCase;

  Future<void> signUpDoctor({required DoctorEntity userEntity}) async {
    emit(AuthInLoadingState());
    try {
      await signUpDoctorUseCase.call(userEntity);
      final uid = await getCurrentUID.call();
      emit(RegisterSuccess(uid: uid));
    } on SocketException catch (e) {
      emit(AuthInErrorState(error: e.toString()));
    } catch (e) {
      emit(AuthInErrorState(error: e.toString()));
    }
  }

  Future<void> sigInDoctor({required DoctorEntity userEntity}) async {
    emit(AuthInLoadingState());
    try {
      await sigInDoctorUseCase.call(userEntity);
      final uid = await getCurrentUID.call();
      final patient = await getSpecificPatientUseCase.call(uid);
      emit(DoctorSignInSuccess(uid: uid.toString()));
      //emit(AuthInSuccessState(uid: uid,patientEntity: patient!));
    } on SocketException catch (e) {
      emit(AuthInErrorState(error: e.toString()));
    } catch (e) {
      emit(AuthInErrorState(error: e.toString()));
    }
  }

  Future<PatientEntity?> getSpecificPatient(String uid) async {
    try {
      final patient = await getSpecificPatientUseCase.call(uid);
      emit(AuthInSuccessState(uid: uid, patientEntity: patient!));
    } catch (error) {
      emit(AuthInErrorState(error: error.toString()));
    }
  }

  Future<void> signInPatient({required PatientEntity patientEntity}) async {
    emit(AuthInLoadingState());
    try {
      await signInPatientUseCase.call(patientEntity);
      final uid = await getCurrentUID.call();
      final patient = await getSpecificPatientUseCase.call(uid);
      emit(AuthInSuccessState(uid: uid, patientEntity: patientEntity));
    } on SocketException catch (e) {
      emit(AuthInErrorState(error: e.toString()));
    } catch (e) {
      emit(AuthInErrorState(error: e.toString()));
    }
  }

  Future<void> signUpPatient({required PatientEntity patientEntity}) async {
    emit(AuthInLoadingState());
    try {
      await signUpPatientUseCase.call(patientEntity);
      final uid = await getCurrentUID.call();
      emit(RegisterSuccess(uid: uid));
      // emit(AuthInSuccessState(uid: uid));
    } on SocketException catch (e) {
      emit(AuthInErrorState(error: e.toString()));
    } catch (e) {
      emit(AuthInErrorState(error: e.toString()));
    }
  }

  Future<void> resetPassword({required String email}) async {
    emit(AuthInLoadingState());
    try {
      await restPasswordUseCase.call(email);
      final uid = await getCurrentUID.call();
      final patient = await getSpecificPatientUseCase.call(uid);
      emit(AuthInSuccessState(uid: uid, patientEntity: patient!));
    } on SocketException catch (e) {
      emit(AuthInErrorState(error: e.toString()));
    } catch (e) {
      emit(AuthInErrorState(error: e.toString()));
    }
  }

  Future<void> getCurrentPatient({
    required PatientEntity userEntity,
  }) async {
    emit(AuthInLoadingState());
    try {
      await currentPatientUseCase.call(userEntity);
      final uid = await getCurrentUID.call();
      emit(RegisterSuccess(uid: uid));
    } catch (error) {
      emit(AuthInErrorState(error: error.toString()));
    }
  }

  Future<void> getCurrentDoctor({required DoctorEntity userEntity}) async {
    emit(AuthInLoadingState());
    try {
      await currentDoctor.call(userEntity);
      final uid = await getCurrentUID.call();
      emit(RegisterSuccess(uid: uid));
    } catch (error) {
      emit(AuthInErrorState(error: error.toString()));
    }
  }

  Future<void> addNewClinic({required ClinicEntity clinicEntity}) async {
    emit(AuthInLoadingState());
    try {
      await addNewClinicUseCase.call(clinicEntity);
      final uid = await getCurrentUID.call();
      final patient = await getSpecificPatientUseCase.call(uid);
      emit(AddClinicSuccess(uid: uid));
      //  emit(AuthInSuccessState(uid:uid,patientEntity: patient!));
    } catch (error) {
      emit(AuthInErrorState(error: error.toString()));
    }
  }

  Future<DoctorEntity?> getSpecificDoctor(String uid) async {
    emit(GetDoctorIsloading());
    try {
      final doctor = await getSpecificDoctorByUid.call(uid);
      emit(GetDoctorData(doctorEntity: doctor!));
    } catch (error) {
      emit(GetDoctorError(error: error.toString()));
    }
  }

  Future<void> userSignout() async {
    try {
      await userSignout.call();
      emit(SignoutSuccess());
    } catch (error) {
      log(error.toString());
    }
  }
}
