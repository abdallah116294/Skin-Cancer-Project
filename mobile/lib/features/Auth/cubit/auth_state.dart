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

class RegisterUserIsLoadingState extends AuthState {}

class RegisterUserIsSuccessSetate extends AuthState {
  final String message;

  const RegisterUserIsSuccessSetate({required this.message});
}

class RegisterUserIsErrorState extends AuthState {
  final String error;

  const RegisterUserIsErrorState({required this.error});
}

class AddRoleSuccesState extends AuthState {
  final AddRoleRespons respons;
  const AddRoleSuccesState({required this.respons});
}

class AddRoleErrorState extends AuthState {
  final String error;
  const AddRoleErrorState({required this.error});

}
