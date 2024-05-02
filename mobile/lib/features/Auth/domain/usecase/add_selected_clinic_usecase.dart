import 'package:mobile/features/Auth/domain/entities/selected_clinic_entity.dart';
import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';

class AddSelectedClinicUseCase{
 final AuthRepo repo;
 AddSelectedClinicUseCase({required this.repo});
 Future<void>call(SelectedClinicEntity selectedClinicEntity)async=>repo.addSelectedClinic(selectedClinicEntity);
}