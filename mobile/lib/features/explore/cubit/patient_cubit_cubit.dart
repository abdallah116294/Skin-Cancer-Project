import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/clinic/data/model/add_clinic_success_model.dart';
import 'package:mobile/features/clinic/data/repo/clinic_repo.dart';
import 'package:mobile/features/explore/data/model/booked_success_model.dart';
import 'package:mobile/features/explore/data/model/clinic_info_model.dart';
import 'package:mobile/features/explore/data/model/clinic_schedual_model.dart';
import 'package:mobile/features/explore/data/model/payment_response.dart';
import 'package:mobile/features/explore/data/repo/patient_clinic_repo.dart';

part 'patient_cubit_state.dart';

class PatientClinicCubit extends Cubit<PatientClinicState> {
  PatientClinicCubit({required this.patientClinicRepo,required this.clinicRepo})
      : super(PatientCubitInitial());
  PatientClinicRepo patientClinicRepo;
    ClinicRepo clinicRepo;
  Future<void> getAllClinics() async {
    emit(GetAllClinicIsLoading());
    try {
      Either<String, List<ClinicInfoModel>> response =
          await patientClinicRepo.getAllClinic();
      emit(response.fold((l) => GetAllClinicIsError(error: l),
          (r) => GetAllClinicIsSuccess(clinicInfoModel: r)));
    } catch (error) {
      emit(GetAllClinicIsError(error: error.toString()));
    }
  }

  Future<void> searchClinic(String name) async {
    emit(GetSearchResultIsLoading());
    try {
      Either<String, List<ClinicInfoModel>> response =
          await patientClinicRepo.searchClinic(name);
      emit(response.fold((l) => GetSearchResultError(error: l),
          (r) => GetSearchResultSuccess(clinicInfoModel: r)));
    } catch (error) {
      emit(GetSearchResultError(error: error.toString()));
    }
  }

  Future<void> getClinicDetails(int id) async {
    emit(GetClinicDetailsIsloading());

    try {
      Either<String, ClinicInfoModel> response =
          await patientClinicRepo.getClinicDetails(id);
      emit(response.fold((l) => GetClinicDetailsIsError(error: l),
          (r) => GetClinicDetailsIsSuccess(clinicInfoModel: r)));
    } catch (error) {
      emit(GetClinicDetailsIsError(error: error.toString()));
    }
  }

  Future<void> patienBookSchedual(
      int scheduleId, String patientId, String token) async {
    emit(PatientBookSchedualIsLoading());

    try {
      Either<String, PatientBookSuccess> response = await patientClinicRepo
          .patientBookSchedual(scheduleId, patientId, token);
      emit(response.fold((l) => PatientBookSchedualError(error: l),
          (r) => PatientBookSchedualIsSuccess(patientBookSuccess: r)));
    } catch (error) {
      emit(PatientBookSchedualError(error: error.toString()));
    }
  }

  Future<void> patientRateClinic(
      String token, int rate, String patientId, int clinicId) async {
    emit(PatientRatingClinicIsLoading());

    try {
      Either<String, PatientBookSuccess> response = await patientClinicRepo
          .patientRateClinic(token, rate, patientId, clinicId);
      emit(response.fold((l) => PatientRatingClinicError(error: l),
          (r) => PatientRatingClinicIsSuccess(patientBookSuccess: r)));
    } catch (error) {
      emit(PatientBookSchedualError(error: error.toString()));
    }
  }

  Future<void> getClinicSchedual(int clinicId) async {
    emit(GetClinicSchedualIsLoading());
    try {
      Either<String, List<ClinicSchedualModel>> response =
          await patientClinicRepo.getClinicSchedual(clinicId);
      emit(response.fold((l) => GetClinicSchedualIsError(error: l),
          (r) => GetClinicSchedualIsSuccess(clinicSchedual: r)));
    } catch (error) {
      emit(GetClinicSchedualIsError(error: error.toString()));
    }
  }

  Future<void> patientPaymentOrder(
    {       required patientId, required int clinicId,required int scheduleId}) async {
    emit(PaymentOrderLoading());
    try {
      Either<String, PaymentResponse> response =
          await patientClinicRepo.paymentOrder(clinicId: clinicId,patientId: patientId,scheduleId: scheduleId);
      emit(response.fold((l) => PaymentOrderError(error: l),
          (r) => PaymentOrderSuccess(paymentResponse: r)));
    } catch (error) {
      emit(PaymentOrderError(error: error.toString()));
    }
  }
    Future<void> docCreateSchadual(String date, bool isBook, int clinicId) async {
    emit(DocCreateSchedualLoading());
    try {
      Either<String, AddClinicSuccessModel> response =
          await clinicRepo.docCreateSchedule(date, isBook, clinicId);
      emit(response.fold((l) => DocCreateSchedualError(error: l),
          (r) => DocCreateSchedualSuccess(selectedClinic: r)));
    } catch (error) {
      emit(DocCreateSchedualError(error: error.toString()));
    }
  }
}
