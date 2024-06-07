import 'package:dartz/dartz.dart';
import 'package:mobile/features/Auth/data/model/doctor_details_model.dart';
import 'package:mobile/features/Auth/data/model/patient_details._model.dart';
import 'package:mobile/features/Auth/data/model/user_model.dart';

import '../model/add_role_response.dart';

abstract class AuthRepo {
  Future<Either<String, UserModel>> loginUser({required String email,required String password});

  Future<Either<String, String>> registerUser({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    required String phoneNumber,
    required String userName,
  });

  Future<Either<String, AddRoleRespons>> addRole(
      String roleName, String userName);

  Future<Either<String, String>> forgetPassword(String email);

  Future<Either<String, String>> resetPassword(
      {required String code,
      required String email,
      required String newPassword});
 
       Future<Either<String,DoctorDetails>>getDoctorDetails(String docId);    
       Future<Either<String,PatientDetails>>getPatientDetails(String patientId);    

}
