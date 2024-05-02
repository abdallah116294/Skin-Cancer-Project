import 'dart:io';

import 'package:mobile/features/Auth/domain/entities/doctor_entity.dart';
import 'package:mobile/features/Auth/domain/entities/patient_entity.dart';
import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';

class GetCurrentPatientUseCase {
  final AuthRepo repo;
  GetCurrentPatientUseCase({required this.repo});
  Future<void>call(PatientEntity userEntity)async=>repo.getCurrentPatient(userEntity);
}