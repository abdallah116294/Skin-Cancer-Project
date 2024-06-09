part of 'patient_cubit_cubit.dart';

sealed class PatientClinicState extends Equatable {
  const PatientClinicState();

  @override
  List<Object> get props => [];
}

final class PatientCubitInitial extends PatientClinicState {}

class GetAllClinicIsLoading extends PatientClinicState {}

class GetAllClinicIsSuccess extends PatientClinicState {
  List<ClinicInfoModel> clinicInfoModel;
  GetAllClinicIsSuccess({required this.clinicInfoModel});
  @override
  List<Object> get props => [clinicInfoModel];
}

class GetAllClinicIsError extends PatientClinicState {
  final String error;
  const GetAllClinicIsError({required this.error});
}

class GetSearchResultIsLoading extends PatientClinicState {}

class GetSearchResultSuccess extends PatientClinicState {
  List<ClinicInfoModel> clinicInfoModel;
  GetSearchResultSuccess({required this.clinicInfoModel});
  @override
  List<Object> get props => [clinicInfoModel];
}

class GetSearchResultError extends PatientClinicState {
  final String error;
  GetSearchResultError({required this.error});
  @override
  List<Object> get props => [error];
}

class GetClinicDetailsIsloading extends PatientClinicState {}

class GetClinicDetailsIsSuccess extends PatientClinicState {
  final ClinicInfoModel clinicInfoModel;
  const GetClinicDetailsIsSuccess({required this.clinicInfoModel});
  @override
  List<Object> get props => [clinicInfoModel];
}

class GetClinicDetailsIsError extends PatientClinicState {
  final String error;
  const GetClinicDetailsIsError({required this.error});
  @override
  List<Object> get props => [error];
}

class PatientBookSchedualIsLoading extends PatientClinicState {}

class PatientBookSchedualIsSuccess extends PatientClinicState {
  final PatientBookSuccess patientBookSuccess;
  PatientBookSchedualIsSuccess({required this.patientBookSuccess});
}

class PatientBookSchedualError extends PatientClinicState {
  final String error;
  PatientBookSchedualError({required this.error});
}

class PatientRatingClinicIsLoading extends PatientClinicState {}

class PatientRatingClinicIsSuccess extends PatientClinicState {
  final PatientBookSuccess patientBookSuccess;
  PatientRatingClinicIsSuccess({required this.patientBookSuccess});
}

class PatientRatingClinicError extends PatientClinicState {
  final String error;
  PatientRatingClinicError({required this.error});
}

class GetClinicSchedualIsLoading extends PatientClinicState {}

class GetClinicSchedualIsSuccess extends PatientClinicState {
  List<ClinicSchedualModel> clinicSchedual;
  GetClinicSchedualIsSuccess({required this.clinicSchedual});
}

class GetClinicSchedualIsError extends PatientClinicState {
  final String error;
  GetClinicSchedualIsError({required this.error});
}

class PaymentOrderLoading extends PatientClinicState {}

class PaymentOrderSuccess extends PatientClinicState {
  final PaymentResponse paymentResponse;
  const PaymentOrderSuccess({required this.paymentResponse});
}

class PaymentOrderError extends PatientClinicState {
  final String error;
  const PaymentOrderError({required this.error});
}
