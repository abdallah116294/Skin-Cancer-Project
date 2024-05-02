import 'package:mobile/features/Auth/domain/entities/patient_entity.dart';
import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';

class SignInPatientUseCase{
  final AuthRepo repo;
  SignInPatientUseCase({required this.repo});
  Future<void>call(PatientEntity patientEntity)async=>repo.signInPatient(patientEntity);
}