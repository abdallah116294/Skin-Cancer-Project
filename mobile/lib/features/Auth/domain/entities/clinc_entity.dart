import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ClinicEntity extends Equatable {
  //final File image;
  final String clinicID;
  final String address;
  final String phonenumber;
  final Timestamp dateTime1;
  final Timestamp dateTime2;
  final Timestamp dateTime3;
  final String uid;
  final String imageUrl;
  final String price;
  final String doctorname;

  const ClinicEntity(
      {required this.uid,
      required this.dateTime1,
      required this.dateTime2,
      required this.dateTime3,
      required this.phonenumber,
      required this.address,
      required this.clinicID,
      required this.imageUrl,
      required this.price,
      required this.doctorname
      // required this.image
      });

  @override
  // TODO: implement props
  List<Object?> get props => [
        //image,
        clinicID, address, phonenumber, dateTime1, dateTime2, dateTime3,
        imageUrl,
        price,
        doctorname
      ];
}
