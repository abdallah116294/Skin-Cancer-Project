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

class GetDocClinicIsLoading extends ClinicState {}

class GetDocClinicIsSuccess extends ClinicState {
  final ClinicModel clinicModel;

  const GetDocClinicIsSuccess({required this.clinicModel});
}

class GetDocClinicIsError extends ClinicState {
  final String error;

  const GetDocClinicIsError({required this.error});
}

class DeleteClinicIsloading extends ClinicState {}

class DeleteClinicIsSuccesse extends ClinicState {
  final AddClinicSuccessModel addClinicSuccessModel;

  const DeleteClinicIsSuccesse({required this.addClinicSuccessModel});
}

class DeleteClinicIsError extends ClinicState {
  final String error;

  DeleteClinicIsError({required this.error});
}



class GetDocHasClinicIsLoading extends ClinicState {}

class GetDocHasClinicIsSuccess extends ClinicState {
  final AddClinicSuccessModel addClinicSuccess;

  const GetDocHasClinicIsSuccess({required this.addClinicSuccess});
}

class GetDocHasClinicIsError extends ClinicState {
  final String error;

  const GetDocHasClinicIsError({required this.error});
}



class UpdateClinicLoading extends ClinicState {}

class UpdateClinicSuccess extends ClinicState {
  final AddClinicSuccessModel addClinicSuccessModel;

  const UpdateClinicSuccess({required this.addClinicSuccessModel});
}

class UpdateClinicError extends ClinicState {
  final String error;

  const UpdateClinicError({required this.error});
}
class GetSelectedClinicIsLoading extends ClinicState {}

class GetSelectedClinicIsSuccess extends ClinicState {
  final List<SelectedClinicModel> selectedClinic;

  const GetSelectedClinicIsSuccess({required this.selectedClinic});
}
class GetSelectedClinicIsError extends ClinicState {
  final String error;

  const GetSelectedClinicIsError({required this.error});
}