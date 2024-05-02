import 'package:mobile/features/Auth/domain/entities/ai_result_entity.dart';
import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';

class GetAIResultUseCase {
  final AuthRepo repo;
  GetAIResultUseCase({required this.repo});
  Future<List<AIResultEntity>> call(String uid)async=>repo.getAiResults(uid);
}
