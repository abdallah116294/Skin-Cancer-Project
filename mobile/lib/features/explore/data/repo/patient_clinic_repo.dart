import 'package:dartz/dartz.dart';
import 'package:mobile/features/explore/data/model/booked_success_model.dart';
import 'package:mobile/features/explore/data/model/clinic_info_model.dart';
import 'package:mobile/features/explore/data/model/clinic_schedual_model.dart';

abstract class PatientClinicRepo {
  Future<Either<String, List<ClinicInfoModel>>> getAllClinic();
  Future<Either<String, List<ClinicInfoModel>>> searchClinic(String name);
  Future<Either<String, ClinicInfoModel>> getClinicDetails(int id);
  Future<Either<String, PatientBookSuccess>> patientBookSchedual(
      int scheduleId, String patientId, String token);
  Future<Either<String, PatientBookSuccess>> patientRateClinic(String token,
      int rate, String patientId, int clinicId);
  Future<Either<String,List<ClinicSchedualModel>>>getClinicSchedual(int clinicId);   
}
