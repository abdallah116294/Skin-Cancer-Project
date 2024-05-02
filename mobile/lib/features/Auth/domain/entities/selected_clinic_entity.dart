import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SelectedClinicEntity extends Equatable {
  //final File image;
  final String clinicID;
  final String address;
  final String phonenumber;
  final Timestamp dateTime1;
  final String uid;
  final String doctorname;
  final String imageUrl;
  final String price;

  const SelectedClinicEntity({
    required this.uid,
    required this.dateTime1,
    required this.phonenumber,
    required this.address,
    required this.clinicID,
    required this.doctorname,
    required this.imageUrl,
    required this.price
    // required this.image
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        //image,
        clinicID, address, phonenumber, dateTime1, doctorname,price,imageUrl
      ];
}
