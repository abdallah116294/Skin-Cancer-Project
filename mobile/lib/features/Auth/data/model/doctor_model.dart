import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/features/Auth/domain/entities/doctor_entity.dart';

class DoctorModel extends DoctorEntity {
  const DoctorModel({required super.name,
    required super.email,
    required super.phonenumber,
    required super.uid,
    required super.status,
    required super.password,
    required super.imageUrl,
    required super.about,
  });
  factory DoctorModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return DoctorModel(
      name: snapshot.data()?['name'] ?? '',
      email: snapshot.data()?['email'] ?? '',
      phonenumber: snapshot.data()?['phonenumber'] ?? '',
      uid: snapshot.data()?['uid'] ?? '',
      status: snapshot.data()?['status'] ?? '',
      password: snapshot.data()?['password'] ?? '',
      about: snapshot.data()?['about']??"", imageUrl: snapshot.data()?['imageUrl']??'',
    );
  }
  factory DoctorModel.fromSnapshot1(DocumentSnapshot snapshot){
    return DoctorModel(name: snapshot.get('name'),
        email: snapshot.get('email'),
        phonenumber: snapshot.get('phonenumber'),
        uid: snapshot.get('uid'),
        status: snapshot.get('status'),
        password: snapshot.get('password'), about: snapshot.get('about'), imageUrl: snapshot.get('imageUrl'));
  }

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
        name: json['name'],
        email: json['email'],
        phonenumber: json['phonenumber'],
        uid: json['uid'],
        status: json['status'],
        password: json['password'], about: json["about"], imageUrl: json['imageUrl']);
  }
  Map<String, dynamic> toDocument() {
    return {
      "status": status,
      "uid": uid,
      "email": email,
      "name": name,
      "phone": phonenumber,
      "about":about,
       "imageUrl":imageUrl
    };
  }
}