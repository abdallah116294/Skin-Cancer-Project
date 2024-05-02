import 'package:mobile/features/Auth/data/model/doctor_model.dart';
import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';

class GetDoctorUseCase{
  AuthRepo repo;
  GetDoctorUseCase({required this.repo});
 Future<List<DoctorModel>>call()async=>repo.getDoctorData();
}