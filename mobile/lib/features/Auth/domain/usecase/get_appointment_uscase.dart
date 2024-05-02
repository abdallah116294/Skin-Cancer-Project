import 'package:mobile/features/Auth/domain/entities/patient_entity.dart';
import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';

class GetAppointmentUseCse{
final AuthRepo repo;
GetAppointmentUseCse({required this.repo});
Future<List<PatientEntity>>call(String uid)async=>repo.getAppointment(uid);
}