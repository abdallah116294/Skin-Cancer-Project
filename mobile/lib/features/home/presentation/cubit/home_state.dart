part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class DoctorDataIsLoading extends HomeState {}

class DoctorDataLoaded extends HomeState {
  final List<DoctorModel> doctors;
  DoctorDataLoaded({required this.doctors});
}

class DoctorDataError extends HomeState {
  final String error;
  DoctorDataError({required this.error});
}

class GetClinicIsLoading extends HomeState {}

class GetClinicLoaded extends HomeState {
  List<ClinicEntity> clinic;
  GetClinicLoaded({required this.clinic});
}

class GetClinicError extends HomeState {
  final String error;
  GetClinicError({required this.error});
}

class AddSelectedClinicSuccess extends HomeState {}

class AddSelectedClinicIsLoading extends HomeState {}

class GetSpecificPatient extends HomeState {
  final PatientEntity patientEntity;
  GetSpecificPatient({required this.patientEntity});
}

class GetSpecificDoctor extends HomeState {
  final DoctorEntity doctorEntity;
  GetSpecificDoctor({required this.doctorEntity});
}

class GetAppointmentLoading extends HomeState {}

class GetAppointmentLoaded extends HomeState {
  List<PatientEntity> patient;
  GetAppointmentLoaded({required this.patient});
}

class GetAppointmentError extends HomeState {
  final String error;
  GetAppointmentError({required this.error});
}

class AddAiResultLoading extends HomeState {}

class AddAiResultLoaded extends HomeState {}

class AddAiResultError extends HomeState {
  final String error;
  AddAiResultError({required this.error});
}

class GetAIResultIsLoading extends HomeState {}

class GetAIResultLoaded extends HomeState {
  final List<AIResultEntity> aiResultEntity;
  GetAIResultLoaded({required this.aiResultEntity});
}

class GetAIResultError extends HomeState {
  final String error;
  GetAIResultError({required this.error});
}

class GeteSlectedClinicIsLoading extends HomeState {}

class GeteSlectedClinicLoaded extends HomeState {
  final List<SelectedClinicEntity> selectedClinic;
  GeteSlectedClinicLoaded({required this.selectedClinic});
}

class GeteSlectedClinicError extends HomeState {
  final String error;
  GeteSlectedClinicError({required this.error});
}

class ChcekoutSendOk extends HomeState {}

class ChcekoutSendError extends HomeState {
  final String error;
  ChcekoutSendError({required this.error});
}
