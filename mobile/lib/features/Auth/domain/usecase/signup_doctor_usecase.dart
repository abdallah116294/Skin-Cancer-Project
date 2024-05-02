import 'package:mobile/features/Auth/domain/entities/doctor_entity.dart';
import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';

class SignUpDoctorUseCase{
  final AuthRepo repo;
  SignUpDoctorUseCase({required this.repo});
  Future<void>call(DoctorEntity userEntity)async
  =>repo.signUpDoctor(userEntity);
}