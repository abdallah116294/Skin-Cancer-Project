import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';

import '../entities/patient_entity.dart';

class GetSpecificPatientUseCase {
 final AuthRepo repo;
 GetSpecificPatientUseCase({required this.repo});
 Future<PatientEntity?>call(String uid)async=>repo.getSpecificPatient(uid);
}