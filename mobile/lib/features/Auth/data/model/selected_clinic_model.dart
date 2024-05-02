import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/features/Auth/domain/entities/clinc_entity.dart';

import '../../domain/entities/selected_clinic_entity.dart';

class SelectedClinicModel extends SelectedClinicEntity {
  SelectedClinicModel({
    required super.uid,
    required super.dateTime1,
    required super.phonenumber,
    required super.address,
    required super.clinicID,
    required super.doctorname,
    required super.imageUrl,
    required super.price,

    // required super.image
  });
  factory SelectedClinicModel.fromSnapShot(DocumentSnapshot documentSnapshot) {
    return SelectedClinicModel(
        uid: documentSnapshot.get('uid') ?? "",
        dateTime1: documentSnapshot.get('dateTime1') ?? "",
        phonenumber: documentSnapshot.get('phonenumber') ?? "",
        address: documentSnapshot.get('address') ?? "",
        clinicID: documentSnapshot.get('clinicID') ?? "",
        doctorname: documentSnapshot.get('doctorname'),
        imageUrl: documentSnapshot.get('imageUrl'),
        price: documentSnapshot.get('price')
        //  image: snapshot.get('image')
        );
  }
  Map<String, dynamic> toDocumnet() {
    return {
      "uid": uid,
      "dateTime1": dateTime1,
      "phonenumber": phonenumber,
      "clinicID": clinicID,
      "address": address,
      "doctorname": doctorname,
      "imageUrl": imageUrl,
      "price": price
      //"image":image,
    };
  }
}
