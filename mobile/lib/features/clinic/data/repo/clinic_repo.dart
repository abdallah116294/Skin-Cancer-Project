import 'package:dartz/dartz.dart';
import 'package:mobile/features/clinic/data/model/add_clinic_success_model.dart';
import 'package:mobile/features/clinic/data/model/clinic_model.dart';

import '../model/update_model.dart';

abstract class ClinicRepo {
  Future<Either<String, AddClinicSuccessModel>> createClinic(
      ClinicModel clinicModel, String token);
  Future<Either<String, ClinicModel>> getDocClinic({required String name});
  Future<Either<String, AddClinicSuccessModel>> deleteClinic({required int id,required String token});
  Future<Either<String, AddClinicSuccessModel>> getDocHasClinic({required String docId});
  Future<Either<String, AddClinicSuccessModel>> updateClinic ( UpdateClinicModel updateClinicModel,String token);
}
