import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/clinic/data/model/add_clinic_success_model.dart';
import 'package:mobile/features/clinic/data/model/clinic_model.dart';
import 'package:mobile/features/clinic/data/model/create_clinic_model.dart';
import 'package:mobile/features/clinic/data/model/selected_clinic_model.dart';
import 'package:mobile/features/clinic/data/model/update_model.dart';
import 'package:mobile/features/clinic/data/repo/clinic_repo.dart';
import 'package:mobile/features/explore/data/repo/patient_clinic_repo.dart';

part 'clinic_state.dart';

class ClinicCubit extends Cubit<ClinicState> {
  ClinicCubit({
    required this.clinicRepo,
    required this.patientClinicRepo,
  }) : super(ClinicInitial());
  ClinicRepo clinicRepo;
  PatientClinicRepo patientClinicRepo;

  Future<void> creatClinic(CreateClinicModel clinicModel, String token) async {
    try {
      Either<String, AddClinicSuccessModel> response =
          await clinicRepo.createClinic(clinicModel, token);
      emit(response.fold((l) => CreateClinicIsError(error: l),
          (r) => CreateClinicIsSuccesse(addClinicSuccessModel: r)));
    } catch (error) {
      emit(CreateClinicIsError(error: error.toString()));
    }
  }

  Future<void> getDocClinic({required String name}) async {
    emit(GetDocClinicIsLoading());

    try {
      Either<String, ClinicModel> response =
          await clinicRepo.getDocClinic(name: name);
      emit(response.fold((l) => GetDocClinicIsError(error: l),
          (r) => GetDocClinicIsSuccess(clinicModel: r)));
    } catch (error) {
      emit(GetDocClinicIsError(error: error.toString()));
    }
  }

  Future<void> deleteClinic({required int id, required String token}) async {
    emit(DeleteClinicIsloading());
    try {
      Either<String, AddClinicSuccessModel> response =
          await clinicRepo.deleteClinic(id: id, token: token);
      emit(response.fold((l) => DeleteClinicIsError(error: l),
          (r) => DeleteClinicIsSuccesse(addClinicSuccessModel: r)));
    } catch (error) {
      emit(DeleteClinicIsError(error: error.toString()));
    }
  }

  Future<void> getDocHasClinic({required String docId}) async {
    emit(GetDocHasClinicIsLoading());
    try {
      Either<String, AddClinicSuccessModel> response =
          await clinicRepo.getDocHasClinic(docId: docId);
      emit(response.fold((l) => GetDocHasClinicIsError(error: l),
          (r) => GetDocHasClinicIsSuccess(addClinicSuccess: r)));
    } catch (error) {
      emit(GetDocHasClinicIsError(error: error.toString()));
    }
  }

  Future<void> updateClinic(
      {required UpdateClinicModel updateClinicModel,
      required String token}) async {
    emit(UpdateClinicLoading());
    try {
      Either<String, AddClinicSuccessModel> response =
          await clinicRepo.updateClinic(updateClinicModel, token);
      emit(response.fold((l) => UpdateClinicError(error: l),
          (r) => UpdateClinicSuccess(addClinicSuccessModel: r)));
    } catch (error) {
      emit(UpdateClinicError(error: error.toString()));
    }
  }

  Future<void> getSelectedClinic(String userId) async {
    emit(GetSelectedClinicIsLoading());
    try {
      Either<String, List<SelectedClinicModel>> response =
          await clinicRepo.getPatineSelectedClinic(userId);
      emit(response.fold((l) => GetSelectedClinicIsError(error: l),
          (r) => GetSelectedClinicIsSuccess(selectedClinic: r)));
    } catch (error) {
      emit(GetSelectedClinicIsError(error: error.toString()));
    }
  }
    Future<void> getClinicAppointments(int clincId) async {
    emit(GetSelectedClinicIsLoading());
    try {
      Either<String, List<SelectedClinicModel>> response =
          await clinicRepo.getClinicAppointment(clincId);
      emit(response.fold((l) => GetSelectedClinicIsError(error: l),
          (r) => GetSelectedClinicIsSuccess(selectedClinic: r)));
    } catch (error) {
      emit(GetSelectedClinicIsError(error: error.toString()));
    }
  }

    Future<void> docCreateSchadual(String date ,bool isBook ,int clinicId ) async {
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
