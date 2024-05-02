import 'package:mobile/features/Auth/domain/entities/patient_entity.dart';
import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';

class SignUpPatientUseCase{
  final AuthRepo repo;
  SignUpPatientUseCase({required this.repo});
  Future<void>call(PatientEntity patientEntity)async=>repo.signUpPatient(patientEntity);
}