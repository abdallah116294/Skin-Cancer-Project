import 'package:mobile/features/Auth/domain/entities/ai_result_entity.dart';
import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';

class AddResult{
 final AuthRepo repo;
 AddResult({required this.repo});
 Future<void>call(AIResultEntity aiResultEntity,String uid,int num)async=>repo.addResult(aiResultEntity, uid, num);
}