import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/Auth/domain/entities/ai_result_entity.dart';
import 'package:mobile/features/Auth/domain/entities/doctor_entity.dart';
import 'package:mobile/features/Auth/domain/entities/prescription_entity.dart';
import 'package:mobile/features/Auth/domain/entities/selected_clinic_entity.dart';
import 'package:mobile/features/Auth/domain/usecase/add_appointment_usecsae.dart';
import 'package:mobile/features/Auth/domain/usecase/add_prescription_uscase.dart';
import 'package:mobile/features/Auth/domain/usecase/add_result_usecase.dart';
import 'package:mobile/features/Auth/domain/usecase/get_ai_results_usecase.dart';
import 'package:mobile/features/Auth/domain/usecase/get_appointment_uscase.dart';
import 'package:mobile/features/Auth/domain/usecase/get_clinic_uscase.dart';
import 'package:mobile/features/Auth/domain/usecase/get_current_UID.dart';
import 'package:mobile/features/Auth/domain/usecase/get_doctor_usecase.dart';
import 'package:mobile/features/Auth/domain/usecase/get_selected_clinic_usecase.dart';

import '../../../Auth/data/model/doctor_model.dart';
import '../../../Auth/domain/entities/clinc_entity.dart';
import '../../../Auth/domain/entities/patient_entity.dart';
import '../../../Auth/domain/usecase/add_selected_clinic_usecase.dart';
import '../../../Auth/domain/usecase/get_specific_doctor_usecase.dart';
import '../../../Auth/domain/usecase/get_specific_patient_uscase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
      {required this.addResult,
      required this.getAppointmentUseCse,
      required this.getCurrentUID,
      required this.getSelectedClinicUseCase,
      required this.doctorUseCase,
      required this.getClinicUseCase,
      required this.selectedClinicUseCase,
      required this.addAppointmentUseCase,
      required this.getSpecificPatientUseCase,
      required this.getSpecificDoctorByUid,
      required this.aiResultUseCase,
      required this.addPrescriptionUseCase})
      : super(HomeInitial());
  final GetDoctorUseCase doctorUseCase;
  final GetClinicUseCase getClinicUseCase;
  final AddSelectedClinicUseCase selectedClinicUseCase;
  final AddAppointmentUseCase addAppointmentUseCase;
  final GetSpecificPatientUseCase getSpecificPatientUseCase;
  final GetCurrentUID getCurrentUID;
  final GetSpecificDoctorByUid getSpecificDoctorByUid;
  final GetAppointmentUseCse getAppointmentUseCse;
  final AddResult addResult;
  final GetAIResultUseCase aiResultUseCase;
  final GetSelectedClinicUseCase getSelectedClinicUseCase;
  final AddPrescriptionUseCase addPrescriptionUseCase;
  Future<void> getDoctorData() async {
    emit(DoctorDataIsLoading());
    try {
      var doctors = await doctorUseCase.call();
      emit(DoctorDataLoaded(doctors: doctors));
    } catch (error) {
      emit(DoctorDataError(error: error.toString()));
    }
  }

  Future<void> getClinic({required String uid}) async {
    emit(GetClinicIsLoading());
    try {
      final clinics = await getClinicUseCase.call(uid);
      emit(GetClinicLoaded(clinic: clinics));
    } catch (error) {
      emit(GetClinicError(error: error.toString()));
    }
  }

  Future<void> addSelectedClinic(
      {required SelectedClinicEntity selectedClinicEntity}) async {
    emit(AddSelectedClinicIsLoading());
    try {
      selectedClinicUseCase.call(selectedClinicEntity);
      // emit(GetClinicLoaded(clinic: clinic));
      emit(AddSelectedClinicSuccess());
    } catch (error) {
      emit(GetClinicError(error: error.toString()));
    }
  }

  Future<void> addAppointment(
      {required PatientEntity patientEntity,
      required String uid,
      required Timestamp date}) async {
    emit(AddSelectedClinicIsLoading());
    try {
      await addAppointmentUseCase.call(patientEntity, uid, date);
      emit(AddSelectedClinicSuccess());
    } catch (error) {
      emit(GetClinicError(error: error.toString()));
    }
  }

  Future<PatientEntity?> getSpecificPatient(String uid, int num) async {
    emit(DoctorDataIsLoading());
    if (num == 0) {
      try {
        final patient = await getSpecificPatientUseCase.call(uid);
        emit(GetSpecificPatient(patientEntity: patient!));
        //emit(AuthInSuccessState(uid: uid, patientEntity: patient!));
      } catch (error) {
        emit(DoctorDataError(error: error.toString()));
        //  emit(AuthInErrorState(error: error.toString()));
      }
    } else if (num == 1) {
      try {
        final patient = await getSpecificDoctorByUid.call(uid);
        emit(GetSpecificDoctor(doctorEntity: patient!));
        //emit(GetSpecificPatient(patientEntity: patient!));
        //emit(AuthInSuccessState(uid: uid, patientEntity: patient!));
      } catch (error) {
        emit(DoctorDataError(error: error.toString()));
        //  emit(AuthInErrorState(error: error.toString()));
      }
    }
  }

  Future<void> getAppointment({required String uid}) async {
    emit(GetAppointmentLoading());
    try {
      final appointment = await getAppointmentUseCse.call(uid);
      emit(GetAppointmentLoaded(patient: appointment));
    } catch (error) {
      emit(GetAppointmentError(error: error.toString()));
    }
  }

  Future<DoctorEntity?> getSpecificDoctor(String uid) async {
    emit(DoctorDataIsLoading());
    try {
      final doctor = await getSpecificDoctorByUid.call(uid);
      emit(GetSpecificDoctor(doctorEntity: doctor!));
    } catch (error) {
      emit(DoctorDataError(error: error.toString()));
    }
  }

  Future<void> addAiResult(
      {required AIResultEntity aiResultEntity,
      required String uid,
      required int num}) async {
    emit(AddAiResultLoaded());
    try {
      await addResult.call(aiResultEntity, uid, num);
      emit(AddAiResultLoaded());
    } catch (error) {
      emit(AddAiResultError(error: error.toString()));
    }
  }

  Future<void> getAiresult(String uid) async {
    emit(GetAIResultIsLoading());
    try {
      final airesults = await aiResultUseCase.call(uid);
      emit(GetAIResultLoaded(aiResultEntity: airesults));
    } catch (error) {
      emit(GetAIResultError(error: error.toString()));
    }
  }

  Future<void> getSelectedClinic(String uid) async {
    emit(GeteSlectedClinicIsLoading());
    try {
      final selectedClinic = await getSelectedClinicUseCase.call(uid);
      emit(GeteSlectedClinicLoaded(selectedClinic: selectedClinic));
    } catch (error) {
      emit(GeteSlectedClinicError(error: error.toString()));
    }
  }

  Future<void> addprescription(String uid, String prescription,String outpust,PrescriptionEntity prescriptionEntity) async {
    try {
      await addPrescriptionUseCase.call(uid, prescription,outpust,prescriptionEntity);
      emit(ChcekoutSendOk());
    } catch (error) {
      emit(ChcekoutSendError(error: error.toString()));
    }
  }
}
