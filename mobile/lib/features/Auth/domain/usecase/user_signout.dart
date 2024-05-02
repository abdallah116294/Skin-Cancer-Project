import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';

class UserSignOutUseCase {
  AuthRepo repo;
  UserSignOutUseCase({required this.repo});
  Future<void> call() async => repo.usersignout();
}
