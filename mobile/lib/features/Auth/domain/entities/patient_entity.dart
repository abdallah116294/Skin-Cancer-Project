import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PatientEntity extends Equatable {
  final String? name;
  final String? email;
  final String? uid;
  final String? status;
  final String? phonenumber;
  final String? password;
  final String ? imageUrl;
  final Timestamp? date ;
  const PatientEntity(
      {this.date,this.imageUrl, this.phonenumber,this.name, this.email, this.uid, this.status, this.password});
  @override
  List<Object?> get props => [
    name,
    email,
    uid,
    status,
    password,
  ];
}