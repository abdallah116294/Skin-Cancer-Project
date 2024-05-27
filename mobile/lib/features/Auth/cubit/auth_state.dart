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

class ForgetPasswordIsLoadingState extends AuthState {}

class ForgetPaswordIsSuccessState extends AuthState {
  final String messge;
  const ForgetPaswordIsSuccessState({required this.messge});
}

class ForgetPasswordIsErrorState extends AuthState {
  final String error;
  const ForgetPasswordIsErrorState({required this.error});
}

class ResetPasswordIsLoadingState extends AuthState {}

class ResetPasswordIsErrorState extends AuthState {
  final message;
  ResetPasswordIsErrorState({required this.message});
}
class ResetPasswordIsSuccessState extends AuthState {
  final message;
  ResetPasswordIsSuccessState({required this.message});
}
class GetDoctorDetialsSuccess extends AuthState {
  final DoctorDetails doctorModel;

  const GetDoctorDetialsSuccess({required this.doctorModel});
}
class GetDoctorDetialsError extends AuthState {
  final String error;

  const GetDoctorDetialsError({required this.error});
}
class GetPatientDetialsSuccess extends AuthState {
  final PatientDetails doctorModel;

  const GetPatientDetialsSuccess({required this.doctorModel});
}
class GetPatientDetialsError extends AuthState {
  final String error;

  const GetPatientDetialsError({required this.error});
}