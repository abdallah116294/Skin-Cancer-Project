import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/features/Auth/domain/entities/clinc_entity.dart';

class ClinicModel extends ClinicEntity {
  ClinicModel(
      {required super.uid,
      required super.dateTime1,
      required super.dateTime2,
      required super.dateTime3,
      required super.phonenumber,
      required super.address,
      required super.clinicID, required super.imageUrl,
      required super.price, required super.doctorname,
     // required super.image
      });
  factory ClinicModel.fromSnapShot(DocumentSnapshot documentSnapshot){
    return ClinicModel(uid: documentSnapshot.get('uid') , dateTime1: documentSnapshot.get('datetime1') , dateTime2: documentSnapshot.get('datetime2'), dateTime3: documentSnapshot.get('datetime3'), phonenumber: documentSnapshot.get('phonenumber'), address: documentSnapshot.get('address'), clinicID: documentSnapshot.get('clinicID'),
        imageUrl: documentSnapshot.get('imageUrl'),
        price: documentSnapshot.get('price'),
        doctorname: documentSnapshot.get('doctorname')

    );
  }
  Map<String,dynamic>toDocumnet(){
    return{
      "uid":uid,
      "datetime1":dateTime1,
      "datetime2":dateTime2,
      "datetime3":dateTime3,
      "phonenumber":phonenumber,
      "clinicID":clinicID,
      "address":address,
      "imageUrl":imageUrl ,
      "price":price,
      'doctorname':doctorname
      //"image":image,
    };
  }
}
