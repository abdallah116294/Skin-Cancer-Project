part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthInLoadingState extends AuthState {}

class AuthInSuccessState extends AuthState {
  final String uid;
  final PatientEntity patientEntity;
  AuthInSuccessState({required this.uid, required this.patientEntity});
}

class DoctorSignInSuccess extends AuthState {
  final String uid;
  DoctorSignInSuccess({required this.uid});
}

class AddClinicSuccess extends AuthState {
  final String uid;
  AddClinicSuccess({required this.uid});
}

class RegisterSuccess extends AuthState {
  final String uid;
  RegisterSuccess({required this.uid});
}

class AuthInErrorState extends AuthState {
  String error;
  AuthInErrorState({required this.error});
}

class GetDoctorIsloading extends AuthState {}

class GetDoctorData extends AuthState {
  final DoctorEntity doctorEntity;
  GetDoctorData({required this.doctorEntity});
}

class GetDoctorError extends AuthState {
  final String error;
  GetDoctorError({required this.error});
}
class SignoutSuccess extends AuthState{
  
}
// class GetSpecificDoctor extends AuthState{
//   final DoctorEntity doctorEntity;
//   GetSpecificDoctor({required this.doctorEntity});
// }