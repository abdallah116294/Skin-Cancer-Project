import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';

class IsSigInUseCase{
  final AuthRepo repo;
  IsSigInUseCase({required this.repo});
  Future<bool>call()async=>repo.isSignIn();
}