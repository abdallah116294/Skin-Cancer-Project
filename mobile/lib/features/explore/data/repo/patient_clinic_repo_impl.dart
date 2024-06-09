import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/exception.dart';
import 'package:mobile/core/network/api_constant.dart';
import 'package:mobile/core/network/api_consumer.dart';
import 'package:mobile/features/explore/data/model/booked_success_model.dart';
import 'package:mobile/features/explore/data/model/clinic_info_model.dart';
import 'package:mobile/features/explore/data/model/clinic_schedual_model.dart';
import 'package:mobile/features/explore/data/model/payment_response.dart';
import 'package:mobile/features/explore/data/repo/patient_clinic_repo.dart';

class PatinetClinicRepoImpl implements PatientClinicRepo {
  ApiConsumer apiConsumer;

  PatinetClinicRepoImpl({required this.apiConsumer});

  @override
  Future<Either<String, List<ClinicInfoModel>>> getAllClinic() async {
    try {
      final response = await apiConsumer.get(ApiConstant.getAllClinics);
      final List<ClinicInfoModel> clinics = (response as List)
          .map((clinic) => ClinicInfoModel.fromJson(clinic))
          .toList();
      return Right(clinics);
    } on ServerException catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, List<ClinicInfoModel>>> searchClinic(
      String name) async {
    try {
      final response = await apiConsumer
          .get(ApiConstant.getClinicByNameEndPoint, queryParameters: {
        "subName": name,
      });
      List<ClinicInfoModel> clinics =
          (response as List).map((e) => ClinicInfoModel.fromJson(e)).toList();
      return Right(clinics);
    } on ServerException catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, ClinicInfoModel>> getClinicDetails(int id) async {
    try {
      final response = await apiConsumer.get("/api/Clinic/GetClinicById$id");
      final clinic = ClinicInfoModel.fromJson(response);
      return Right(clinic);
    } on ServerException catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, PatientBookSuccess>> patientBookSchedual(
      int scheduleId, String patientId, String token) async {
    try {
      final response = await apiConsumer.post(
          ApiConstant.patientBookScheduleEndPoint,
          body: {"scheduleId": scheduleId, "patientId": patientId},
          token: token);
      final success = PatientBookSuccess.fromJson(response);
      return Right(success);
    } on ServerException catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, PatientBookSuccess>> patientRateClinic(
      String token, int rate, String patientId, int clinicId) async {
    try {
      final response = await apiConsumer.post(
          ApiConstant.patientRateClinicEndPoint,
          body: {"rate": rate, "patientId": patientId, "clinicId": clinicId},
          token: token);
      final success = PatientBookSuccess.fromJson(response);
      return Right(success);
    } on ServerException catch (eror) {
      return Left(eror.toString());
    }
  }

  @override
  Future<Either<String, List<ClinicSchedualModel>>> getClinicSchedual(
      int clinicId) async {
    try {
      final rseponse = await apiConsumer.get(
          ApiConstant.getClinicSchedulesclinicIdEndPoint,
          queryParameters: {"clinicId": clinicId});
      List<ClinicSchedualModel> clinicScheduals = (rseponse as List)
          .map((e) => ClinicSchedualModel.fromJson(e))
          .toList();
      return Right(clinicScheduals);
    } on ServerException catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, PaymentResponse>> paymentOrder(
      String patientId, int clinicId, int scheduleId) async {
    try {
      final response = await apiConsumer.post(ApiConstant.paymentOrder, body: {
        "patientId": patientId,
        "clinicId": clinicId,
        "scheduleId": scheduleId
      });
      var result = PaymentResponse.fromJson(response);
      return Right(result);
    } on ServerException catch (error) {
      return Left(error.toString());
    }
  }
}
