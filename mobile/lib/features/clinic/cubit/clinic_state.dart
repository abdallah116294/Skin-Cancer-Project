part of 'clinic_cubit.dart';

sealed class ClinicState extends Equatable {
  const ClinicState();

  @override
  List<Object> get props => [];
}

final class ClinicInitial extends ClinicState {}

class CreateClinicIsloading extends ClinicState {}

class CreateClinicIsSuccesse extends ClinicState {
  final AddClinicSuccessModel addClinicSuccessModel;
  const CreateClinicIsSuccesse({required this.addClinicSuccessModel});
}

class CreateClinicIsError extends ClinicState {
  final String error;
  CreateClinicIsError({required this.error});
}
