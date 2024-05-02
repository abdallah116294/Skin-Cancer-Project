import 'package:mobile/features/Auth/domain/entities/clinc_entity.dart';
import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';

class GetClinicUseCase{
 final AuthRepo repo;
 GetClinicUseCase({required this.repo});
 Future<List<ClinicEntity>>call(String uid)async=>repo.getClinic(uid);
}