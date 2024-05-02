import 'package:mobile/features/Auth/domain/entities/clinc_entity.dart';
import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';

class AddNewClinicUseCase {
  final AuthRepo repo;
  AddNewClinicUseCase({required this.repo});
  Future<void>call(ClinicEntity clinicEntity)async=>repo.addNewClinic(clinicEntity);
}