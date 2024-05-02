import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/features/Auth/domain/entities/patient_entity.dart';
import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';

class AddAppointmentUseCase{
  AuthRepo repo;
  AddAppointmentUseCase({required this.repo});
  Future<void>call(PatientEntity patientEntity,String uid,Timestamp date)async=>repo.addAppointment(patientEntity,uid,date);
}