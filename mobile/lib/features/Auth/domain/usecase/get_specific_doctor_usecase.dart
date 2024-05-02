import 'package:mobile/features/Auth/domain/entities/doctor_entity.dart';
import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';

class GetSpecificDoctorByUid{
 final AuthRepo repo;
 GetSpecificDoctorByUid({required this.repo});
 Future<DoctorEntity?>call(String uid)async=>repo.getSpecificDoctor(uid);
}