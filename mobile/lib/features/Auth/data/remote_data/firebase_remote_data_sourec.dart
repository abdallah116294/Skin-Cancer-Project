import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/features/Auth/domain/entities/patient_entity.dart';
import 'package:mobile/features/Auth/domain/entities/prescription_entity.dart';

import '../../domain/entities/ai_result_entity.dart';
import '../../domain/entities/clinc_entity.dart';
import '../../domain/entities/doctor_entity.dart';
import '../../domain/entities/selected_clinic_entity.dart';
import '../model/doctor_model.dart';

abstract class FirebaseRemoteDataSource {
  Future<void> signUpDoctor(DoctorEntity userEntity);
  Future<void> signUpPatient(PatientEntity patientEntity);
  Future<void> singInDoctor(DoctorEntity userEntity);
  Future<void> signInPatient(PatientEntity patientEntity);
  Future<bool> isSignIn();
  Future<void> usersignOut();
  Future<String> getCurrentUID();
  Future<void> resetPassword(String email);
  Future<void> getCreatePatientUser(PatientEntity patientEntity);
  Future<void> getCreateDoctorUser(DoctorEntity doctorEntity);
  Future<void> addClinic(ClinicEntity clinicEntity);
  Future<List<DoctorModel>> getDoctorData();
  Future<PatientEntity?> getSpecificPatientByID(String uid);
  Future<List<ClinicEntity>> getClinic(String uid);
  Future<void> addSelectedClinic(SelectedClinicEntity selectedClinicEntity);
  Future<void> addAppointment(
      PatientEntity patientEntity, String uid, Timestamp data);
  Future<List<PatientEntity>> getAppointment(String uid);
  Future<DoctorEntity?> getSpecificDoctorById(String uid);
  Future<void> addResult(AIResultEntity aiResultEntity, String uid, int num);
  Future<List<AIResultEntity>> getAIResults(String uid);
  Future<List<SelectedClinicEntity>> getSelectedClinic(String uid);
  Future<void> addPrescription(String uid,String prescription,String outputs,PrescriptionEntity prescriptionEntity);
  // Future<String>uploadPatientImage(String email,File image);
}
