import 'package:dartz/dartz.dart';
import 'package:mobile/features/Auth/data/model/doctor_details_model.dart';
import 'package:mobile/features/clinic/data/model/add_clinic_success_model.dart';
import 'package:mobile/features/clinic/data/model/clinic_model.dart';
import 'package:mobile/features/clinic/data/model/create_clinic_model.dart';
import 'package:mobile/features/clinic/data/model/selected_clinic_model.dart';

import '../model/update_model.dart';

abstract class ClinicRepo {
  Future<Either<String, AddClinicSuccessModel>> createClinic(
      CreateClinicModel createClinicModel, String token);
  Future<Either<String, ClinicModel>> getDocClinic({required String name});
  Future<Either<String, AddClinicSuccessModel>> deleteClinic(
      {required int id, required String token});
  Future<Either<String, AddClinicSuccessModel>> getDocHasClinic(
      {required String docId});
  Future<Either<String, AddClinicSuccessModel>> updateClinic(
      UpdateClinicModel updateClinicModel, String token);
  Future<Either<String, List<SelectedClinicModel>>> getPatineSelectedClinic(
      String userId);
  //Future<Either<String,List<SelectedClinicModel>>>getClinicAppointment(int id);    
  Future<Either<String, List<SelectedClinicModel>>>getClinicAppointment(int id);

  Future<Either<String,AddClinicSuccessModel >> docCreateSchedule(
      String date, bool isBook, int clinicId);
  Future<Either<String,DoctorDetails>>getDoctorDetails(String docId);    

}
