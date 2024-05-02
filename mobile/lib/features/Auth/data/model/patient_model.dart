import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/features/Auth/domain/entities/doctor_entity.dart';
import 'package:mobile/features/Auth/domain/entities/patient_entity.dart';

class PatientModel extends PatientEntity {
  const PatientModel({required super.name,
    required super.email,
    required super.phonenumber,
    required super.uid,
    required super.status,
    required super.imageUrl,
    required super.date,
    required super.password
  });

  factory PatientModel.fromSnapshot(DocumentSnapshot snapshot){
    return PatientModel(name: snapshot.get('name')??"",
        email: snapshot.get('email')??"",
        phonenumber: snapshot.get('phonenumber')??"",
        uid: snapshot.get('uid')??"",
        status: snapshot.get('status')??"",
        password: snapshot.get('password')??"",
        imageUrl: snapshot.get('imageUrl')??"" ,
        date:snapshot.get("date")??""
    );
  }
  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
        name: json['name'],
        email: json['email'],
        phonenumber: json['phonenumber'],
        uid: json['uid'],
        status: json['status'],
        password: json['password'],
        imageUrl: json['imageUrl'],
      date:json['date']
    );
  }
  Map<String, dynamic> toDocument() {
    return {
      "status": status,
      "uid": uid,
      "email": email,
      "name": name,
      "phonenumber": phonenumber,
      "imageUrl":imageUrl,
      "password":password,
      "date":date

    };
  }
}