import 'package:mobile/features/Auth/domain/entities/selected_clinic_entity.dart';
import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';

class GetSelectedClinicUseCase {
  final AuthRepo repo;
  GetSelectedClinicUseCase({required this.repo});
  Future<List<SelectedClinicEntity>> call(String uid) async =>
      repo.getSelectedClinic(uid);
}
