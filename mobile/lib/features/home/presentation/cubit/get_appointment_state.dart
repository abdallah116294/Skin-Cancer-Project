part of 'get_appointment_cubit.dart';

@immutable
abstract class GetAppointmentState {}

class GetAppointmentInitial extends GetAppointmentState {}
class GetAppointmentLoading1 extends GetAppointmentState{}
class GetAppointmentLoaded1 extends GetAppointmentState{
  List<PatientEntity>patient;
  GetAppointmentLoaded1({required this.patient});
}
class GetAppointmentError1 extends GetAppointmentState {
  final String error;
  GetAppointmentError1({required this.error});
}