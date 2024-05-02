import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';
class GetCurrentUID{
 final AuthRepo repo;
 GetCurrentUID({required this.repo});
 Future<String>call()async=>repo.getCurrentUID();
}