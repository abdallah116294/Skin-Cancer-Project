import 'package:mobile/features/Auth/domain/entities/prescription_entity.dart';
import 'package:mobile/features/Auth/domain/repository/auth_repo.dart';

class AddPrescriptionUseCase {
  final AuthRepo repo;
  AddPrescriptionUseCase({required this.repo});
  Future<void> call(String uid, String prescription,String outpust,PrescriptionEntity prescriptionEntity) async =>
      repo.addprescription(uid, prescription,outpust,prescriptionEntity);
}
