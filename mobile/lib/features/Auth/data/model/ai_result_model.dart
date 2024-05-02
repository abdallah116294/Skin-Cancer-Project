import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/features/Auth/domain/entities/ai_result_entity.dart';

class AiResultModel extends AIResultEntity{
 const  AiResultModel({
   required super.imageUrl,
   required super.output,
   required super.aiUid,
   required super.prescription,
  required super.uid
     });
  factory AiResultModel.fromSnapShot(DocumentSnapshot snapshot){
       return AiResultModel(imageUrl: snapshot.get('imageUrl'), output: snapshot.get('output'), aiUid: snapshot.get('aiUid'), prescription: snapshot.get('prescription'), uid: snapshot.get('uid'));
  }
  Map<String,dynamic>toDocument(){
    return {
      "imageUrl":imageUrl,
      "output":output,
      "aiUid":aiUid,
      "prescription":prescription,
      "uid":uid,
    };
  }
}