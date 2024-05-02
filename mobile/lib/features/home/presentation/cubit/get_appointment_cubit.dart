import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../Auth/domain/entities/patient_entity.dart';
import '../../../Auth/domain/usecase/get_appointment_uscase.dart';

part 'get_appointment_state.dart';

class GetAppointmentCubit extends Cubit<GetAppointmentState> {
  GetAppointmentCubit({required this.getAppointmentUseCse})
      : super(GetAppointmentInitial());
  final GetAppointmentUseCse getAppointmentUseCse;

  Future<void> getAppointment({required String uid}) async {
    emit(GetAppointmentLoading1());
    try {
      final appointment = await getAppointmentUseCse.call(uid);
      emit(GetAppointmentLoaded1(patient: appointment));
    } catch (error) {
      emit(GetAppointmentError1(error: error.toString()));
    }
  }
}