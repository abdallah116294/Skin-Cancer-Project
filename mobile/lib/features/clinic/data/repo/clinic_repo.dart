import 'package:dartz/dartz.dart';
import 'package:mobile/features/clinic/data/model/add_clinic_success_model.dart';
import 'package:mobile/features/clinic/data/model/clinic_model.dart';

abstract class ClinicRepo {
  Future<Either<String, AddClinicSuccessModel>> createClinic(ClinicModel clinicModel,String token);
  Future<Either<String, ClinicModel>> getDocClinic({required String name});
  Future<Either<String, ClinicModel>> updateClinic(ClinicModel clinicModel,String token);
}
