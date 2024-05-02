import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/features/Auth/domain/entities/ai_result_entity.dart';
import 'package:mobile/features/Auth/domain/entities/prescription_entity.dart';

class PrescriptionModel extends PrescriptionEntity {
  const PrescriptionModel(
      {required super.imageUrl,
      required super.output,
      required super.aiUid,
      required super.prescription,
      required super.uid});
  factory PrescriptionModel.fromSnapShot(DocumentSnapshot snapshot) {
    return PrescriptionModel(
        imageUrl: snapshot.get('imageUrl'),
        output: snapshot.get('output'),
        aiUid: snapshot.get('aiUid'),
        prescription: snapshot.get('prescription'),
        uid: snapshot.get('uid'));
  }
  factory PrescriptionModel.fromJson(jsondata) {
    return PrescriptionModel(
        imageUrl: jsondata['PrescriptionModel'],
        output: jsondata['output'],
        aiUid: jsondata['aiUid'],
        prescription: jsondata['prescription'],
        uid: jsondata['uid']);
  }

  Map<String, dynamic> toDocument() {
    return {
      "imageUrl": imageUrl,
      "output": output,
      "aiUid": aiUid,
      "prescription": prescription,
      "uid": uid,
    };
  }
}
