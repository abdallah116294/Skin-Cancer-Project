part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class LoginUserIsLoadingState extends AuthState {}

class LoginUserIsSuccessSetate extends AuthState {
  final UserModel userModel;
  const LoginUserIsSuccessSetate({required this.userModel});
}

class LoginUserIsErrorState extends AuthState {
  final String error;
  const LoginUserIsErrorState({required this.error});
}
