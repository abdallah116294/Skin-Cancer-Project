import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';

class RestPasswordUseCase{
  final AuthRepo repo;
  RestPasswordUseCase({required this.repo});
 Future<void>call(String email)async=>repo.resetPassword(email) ;
}