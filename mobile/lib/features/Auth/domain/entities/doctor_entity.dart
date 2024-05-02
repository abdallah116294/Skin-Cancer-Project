import 'package:equatable/equatable.dart';

class DoctorEntity extends Equatable {
  final String? name;
  final String? email;
  final String? uid;
  final String? status;
  final String? phonenumber;
  final String? password;
  final String? about;
  final String? imageUrl;
  const DoctorEntity(
      {this.imageUrl, this.about,this.phonenumber,this.name, this.email, this.uid, this.status, this.password});
  @override
  List<Object?> get props => [
    name,
    email,
    uid,
    status,
    password,
    about,
    imageUrl,
  ];
}