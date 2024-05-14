import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/clinic/data/model/add_clinic_success_model.dart';
import 'package:mobile/features/clinic/data/model/clinic_model.dart';
import 'package:mobile/features/clinic/data/repo/clinic_repo.dart';

part 'clinic_state.dart';

class ClinicCubit extends Cubit<ClinicState> {
  ClinicCubit({required this.clinicRepo}) : super(ClinicInitial());
  ClinicRepo clinicRepo;

  Future<void> creatClinic(ClinicModel clinicModel, String token) async {
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
}
