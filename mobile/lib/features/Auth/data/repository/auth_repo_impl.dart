import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/features/Auth/data/model/doctor_model.dart';
import 'package:mobile/features/Auth/data/remote_data/firebase_remote_data_sourec.dart';
import 'package:mobile/features/Auth/domain/entities/ai_result_entity.dart';
import 'package:mobile/features/Auth/domain/entities/clinc_entity.dart';
import 'package:mobile/features/Auth/domain/entities/doctor_entity.dart';
import 'package:mobile/features/Auth/domain/entities/patient_entity.dart';
import 'package:mobile/features/Auth/domain/entities/prescription_entity.dart';
import 'package:mobile/features/Auth/domain/entities/selected_clinic_entity.dart';
import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  FirebaseRemoteDataSource remoteDataSource;
  AuthRepoImpl({required this.remoteDataSource});
  @override
  Future<String> getCurrentUID() async => remoteDataSource.getCurrentUID();

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<void> signInDoctor(DoctorEntity userEntity) async =>
      remoteDataSource.singInDoctor(userEntity);

  @override
  Future<void> signUpDoctor(DoctorEntity userEntity) async =>
      remoteDataSource.signUpDoctor(userEntity);

  @override
  Future<void> resetPassword(String email) async =>
      remoteDataSource.resetPassword(email);

  @override
  Future<void> getCurrentPatient(PatientEntity userEntity) async =>
      remoteDataSource.getCreatePatientUser(userEntity);

  @override
  Future<void> getCurrentDoctor(DoctorEntity userEntity) async =>
      remoteDataSource.getCreateDoctorUser(userEntity);

  @override
  Future<void> addNewClinic(ClinicEntity clinicEntity) async =>
      remoteDataSource.addClinic(clinicEntity);

  @override
  Future<void> signInPatient(PatientEntity patientEntity) async =>
      remoteDataSource.signInPatient(patientEntity);

  @override
  Future<void> signUpPatient(PatientEntity patientEntity) async =>
      remoteDataSource.signUpPatient(patientEntity);

  @override
  Future<List<DoctorModel>> getDoctorData() async =>
      remoteDataSource.getDoctorData();

  @override
  Future<PatientEntity?> getSpecificPatient(String uid) async =>
      remoteDataSource.getSpecificPatientByID(uid);

  @override
  Future<List<ClinicEntity>> getClinic(String uid) async =>
      remoteDataSource.getClinic(uid);

  @override
  Future<void> addSelectedClinic(
          SelectedClinicEntity selectedClinicEntity) async =>
      remoteDataSource.addSelectedClinic(selectedClinicEntity);

  @override
  Future<void> addAppointment(
          PatientEntity patientEntity, String uid, Timestamp date) async =>
      remoteDataSource.addAppointment(patientEntity, uid, date);

  @override
  Future<DoctorEntity?> getSpecificDoctor(String uid) async =>
      remoteDataSource.getSpecificDoctorById(uid);

  @override
  Future<List<PatientEntity>> getAppointment(String uid) async =>
      remoteDataSource.getAppointment(uid);

  @override
  Future<void> addResult(
          AIResultEntity aiResultEntity, String uid, int num) async =>
      remoteDataSource.addResult(aiResultEntity, uid, num);

  @override
  Future<void> usersignout() async => remoteDataSource.usersignOut();

  @override
  Future<List<AIResultEntity>> getAiResults(String uid) async =>
      remoteDataSource.getAIResults(uid);

  @override
  Future<List<SelectedClinicEntity>> getSelectedClinic(String uid) async =>
      remoteDataSource.getSelectedClinic(uid);

  @override
  Future<void> addprescription(String uid, String prescription,String outputs,PrescriptionEntity prescriptionEntity) async =>
      remoteDataSource.addPrescription(uid, prescription,outputs, prescriptionEntity);
}
