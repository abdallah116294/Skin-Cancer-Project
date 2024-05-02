import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/features/Auth/data/model/doctor_model.dart';
import 'package:mobile/features/Auth/domain/entities/ai_result_entity.dart';
import 'package:mobile/features/Auth/domain/entities/clinc_entity.dart';
import 'package:mobile/features/Auth/domain/entities/doctor_entity.dart';
import 'package:mobile/features/Auth/domain/entities/patient_entity.dart';
import 'package:mobile/features/Auth/domain/entities/prescription_entity.dart';
import 'package:mobile/features/Auth/domain/entities/selected_clinic_entity.dart';

abstract class AuthRepo {
  Future<void> signInDoctor(DoctorEntity userEntity);
  Future<void> signUpDoctor(DoctorEntity userEntity);
  Future<void> signInPatient(PatientEntity patientEntity);
  Future<void> signUpPatient(PatientEntity patientEntity);
  Future<String> getCurrentUID();
  Future<bool> isSignIn();
  Future<void> resetPassword(String email);
  Future<void> getCurrentPatient(PatientEntity userEntity);
  Future<void> getCurrentDoctor(DoctorEntity userEntity);
  Future<void> addNewClinic(ClinicEntity clinicEntity);
  Future<List<DoctorModel>> getDoctorData();
  Future<PatientEntity?> getSpecificPatient(String uid);
  Future<List<ClinicEntity>> getClinic(String uid);
  Future<void> addSelectedClinic(SelectedClinicEntity selectedClinicEntity);
  Future<void> addAppointment(
      PatientEntity patientEntity, String uid, Timestamp date);
  Future<DoctorEntity?> getSpecificDoctor(String uid);
  Future<List<PatientEntity>> getAppointment(String uid);
  Future<void> addResult(AIResultEntity aiResultEntity, String uid, int num);
  Future<void> usersignout();
  Future<List<AIResultEntity>> getAiResults(String uid);
  Future<List<SelectedClinicEntity>> getSelectedClinic(String uid);
  Future<void> addprescription(String uid, String prescription,String outputs,PrescriptionEntity prescriptionEntity);
}
