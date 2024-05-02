import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobile/features/Auth/data/model/ai_result_model.dart';
import 'package:mobile/features/Auth/data/model/clinic_model.dart';
import 'package:mobile/features/Auth/data/model/doctor_model.dart';
import 'package:mobile/features/Auth/data/model/patient_model.dart';
import 'package:mobile/features/Auth/data/model/selected_clinic_model.dart';
import 'package:mobile/features/Auth/domain/entities/ai_result_entity.dart';
import 'package:mobile/features/Auth/domain/entities/doctor_entity.dart';
import 'package:mobile/features/Auth/domain/entities/patient_entity.dart';
import 'package:mobile/features/Auth/domain/entities/prescription_entity.dart';

import '../../domain/entities/clinc_entity.dart';
import '../../domain/entities/selected_clinic_entity.dart';
import 'firebase_remote_data_sourec.dart';
import 'package:mobile/injection_container.dart' as di;

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;

  FirebaseRemoteDataSourceImpl(
      {required this.auth,
      required this.firestore,
      required this.firebaseStorage});

  @override
  Future<void> signUpDoctor(DoctorEntity userEntity) async =>
      auth.createUserWithEmailAndPassword(
          email: userEntity.email!, password: userEntity.password!);

  @override
  Future<void> singInDoctor(DoctorEntity userEntity) async =>
      auth.signInWithEmailAndPassword(
          email: userEntity.email!, password: userEntity.password!);

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<String> getCurrentUID() async => auth.currentUser!.uid;

  @override
  Future<void> resetPassword(String email) async =>
      auth.sendPasswordResetEmail(email: email);

  @override
  Future<void> getCreatePatientUser(
    PatientEntity doctorEntity,
  ) async {
    final patientCollection = firestore.collection("patient");
    final uid = await getCurrentUID();
    //final imgurl=await uploadPatientImage(doctorEntity.email.toString(), image);
    patientCollection.doc(uid).get().then((value) {
      final newPatient = PatientModel(
              name: doctorEntity.name,
              email: doctorEntity.email,
              phonenumber: doctorEntity.phonenumber,
              uid: uid,
              status: doctorEntity.status,
              password: doctorEntity.password,
              imageUrl: doctorEntity.imageUrl,
              date: Timestamp.now())
          .toDocument();
      if (!value.exists) {
        patientCollection.doc(uid).set(newPatient);
      }
    });
  }

  @override
  Future<void> getCreateDoctorUser(DoctorEntity userEntity) async {
    final doctorCollection = firestore.collection("doctor");
    final uid = await getCurrentUID();
    doctorCollection.doc(uid).get().then((value) {
      final newDoctor = DoctorModel(
              name: userEntity.name,
              email: userEntity.email,
              phonenumber: userEntity.phonenumber,
              uid: uid,
              status: userEntity.status,
              password: userEntity.password,
              about: userEntity.about,
              imageUrl: userEntity.imageUrl)
          .toDocument();
      if (!value.exists) {
        doctorCollection.doc(uid).set(newDoctor);
      }
    });
  }

  @override
  Future<void> addClinic(ClinicEntity clinicEntity) async {
    final clinicCollectionRef = firestore
        .collection("doctor")
        .doc(clinicEntity.uid)
        .collection('clinic');
    final clinicId = clinicCollectionRef.doc().id;
    clinicCollectionRef.doc(clinicId).get().then((value) {
      final newClinic = ClinicModel(
              clinicID: clinicId,
              uid: clinicEntity.uid,
              imageUrl: clinicEntity.imageUrl,
              //  image: clinicEntity.image,
              phonenumber: clinicEntity.phonenumber,
              address: clinicEntity.address,
              dateTime1: clinicEntity.dateTime1,
              dateTime2: clinicEntity.dateTime2,
              dateTime3: clinicEntity.dateTime3,
              price: clinicEntity.price,
              doctorname: clinicEntity.doctorname)
          .toDocumnet();
      if (!value.exists) {
        clinicCollectionRef.doc(clinicId).set(newClinic);
      }
      return;
    });
  }

  @override
  Future<void> signInPatient(PatientEntity patientEntity) async =>
      auth.signInWithEmailAndPassword(
          email: patientEntity.email!, password: patientEntity.password!);

  @override
  Future<void> signUpPatient(PatientEntity patientEntity) async =>
      auth.createUserWithEmailAndPassword(
          email: patientEntity.email!, password: patientEntity.password!);

  @override
  Future<List<DoctorModel>> getDoctorData() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('doctor').get();
    return querySnapshot.docs
        .map((doc) => DoctorModel.fromSnapshot(doc))
        .toList();
  }

  @override
  Future<PatientEntity?> getSpecificPatientByID(String uid) async {
    try {
      final userCollectionRe = firestore.collection("patient");
      DocumentSnapshot userDoc = await userCollectionRe.doc(uid).get();
      if (userDoc.exists) {
        return PatientModel.fromJson(userDoc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<List<ClinicEntity>> getClinic(String uid) async {
    final clinicCollectionRef =
        firestore.collection('doctor').doc(uid).collection('clinic');
    final snapshot = await clinicCollectionRef.get();
    final clinics =
        snapshot.docs.map((e) => ClinicModel.fromSnapShot(e)).toList();
    return clinics;
  }

  @override
  Future<void> addSelectedClinic(
      SelectedClinicEntity selectedClinicEntity) async {
    final clinicCollectionRef = firestore
        .collection("patient")
        .doc(selectedClinicEntity.uid)
        .collection('selectedClinic');
    final clinicId = clinicCollectionRef.doc().id;
    clinicCollectionRef.doc(clinicId).get().then((value) {
      final newClinic = SelectedClinicModel(
              clinicID: clinicId,
              uid: selectedClinicEntity.uid,
              //  image: clinicEntity.image,
              phonenumber: selectedClinicEntity.phonenumber,
              address: selectedClinicEntity.address,
              dateTime1: selectedClinicEntity.dateTime1,
              doctorname: selectedClinicEntity.doctorname,
              imageUrl: selectedClinicEntity.imageUrl,
              price: selectedClinicEntity.price)
          .toDocumnet();
      if (!value.exists) {
        clinicCollectionRef.doc(clinicId).set(newClinic);
      }
      return;
    });
  }

  @override
  Future<void> addAppointment(
      PatientEntity patientEntity, String uid, Timestamp date) async {
    final appointmentCollectionRef =
        firestore.collection("doctor").doc(uid).collection('appointment');
    final clinicId = appointmentCollectionRef.doc().id;
    appointmentCollectionRef.doc(clinicId).get().then((value) {
      final newAppointment = PatientModel(
        //   clinicID: clinicId,
        uid: patientEntity.uid,
        name: patientEntity.name,

        //  image: clinicEntity.image,
        phonenumber: '', email: patientEntity.email, status: '',
        imageUrl: patientEntity.imageUrl, password: '', date: date,
        // address: selectedClinicEntity.address,
        //  dateTime1: selectedClinicEntity.dateTime1,
      ).toDocument();
      if (!value.exists) {
        appointmentCollectionRef.doc(clinicId).set(newAppointment);
      }
      return;
    });
  }

  @override
  Future<List<PatientEntity>> getAppointment(String uid) async {
    final clinicCollectionRef =
        firestore.collection('doctor').doc(uid).collection('appointment');
    final snapshot = await clinicCollectionRef.get();
    final appoints =
        snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).toList();
    return appoints;
  }

  @override
  Future<DoctorEntity?> getSpecificDoctorById(String uid) async {
    try {
      final userCollectionRe = firestore.collection("doctor");
      DocumentSnapshot userDoc = await userCollectionRe.doc(uid).get();
      if (userDoc.exists) {
        return DoctorModel.fromJson(userDoc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<void> addResult(
      AIResultEntity aiResultEntity, String uid, int num) async {
    if (num == 0) {
      final resultCollectionRef =
          firestore.collection('patient').doc(uid).collection('aiResult');
      final resultuid = resultCollectionRef.doc().id;
      resultCollectionRef.doc(resultuid).get().then((value) {
        final newAiResult = AiResultModel(
                imageUrl: aiResultEntity.imageUrl,
                output: aiResultEntity.output,
                aiUid: aiResultEntity.aiUid,
                prescription: aiResultEntity.prescription,
                uid: aiResultEntity.uid)
            .toDocument();
        if (!value.exists) {
          resultCollectionRef.doc(resultuid).set(newAiResult);
        }
      });
      return;
    } else if (num == 1) {
      final resultCollectionRef =
          firestore.collection('doctor').doc(uid).collection('aiResult');
      final resultuid = resultCollectionRef.doc().id;
      resultCollectionRef.doc(resultuid).get().then((value) {
        final newAiResult = AiResultModel(
                imageUrl: aiResultEntity.imageUrl,
                output: aiResultEntity.output,
                aiUid: aiResultEntity.aiUid,
                uid: aiResultEntity.aiUid,
                prescription: "")
            .toDocument();
        if (!value.exists) {
          resultCollectionRef.doc(resultuid).set(newAiResult);
        }
      });
      return;
    }
  }

  @override
  Future<void> usersignOut() async => auth.signOut();

  @override
  Future<List<AIResultEntity>> getAIResults(String uid) async {
    final airesultCollectionRef =
        firestore.collection('patient').doc(uid).collection('aiResult');
    final snapshot = await airesultCollectionRef.get();
    final airesults =
        snapshot.docs.map((e) => AiResultModel.fromSnapShot(e)).toList();
    return airesults;
  }

  @override
  Future<List<SelectedClinicEntity>> getSelectedClinic(String uid) async {
    final selectedClinicCollectionRef =
        firestore.collection('patient').doc(uid).collection('selectedClinic');
    final snapshot = await selectedClinicCollectionRef.get();
    final selecteClinic =
        snapshot.docs.map((e) => SelectedClinicModel.fromSnapShot(e)).toList();
    return selecteClinic;
  }

  @override
  Future<void> addPrescription(
      String uid, String prescription, String outputs,PrescriptionEntity prescriptionEntity) async {
       final resultCollectionRef =
          firestore.collection('patient').doc(uid).collection('prescription');
      final resultuid = resultCollectionRef.doc().id;
      resultCollectionRef.doc(resultuid).get().then((value) {
        final newAiResult = AiResultModel(
                imageUrl: prescriptionEntity.imageUrl,
                output: prescriptionEntity.output,
                aiUid: prescriptionEntity.aiUid,
                prescription: prescriptionEntity.prescription,
                uid: prescriptionEntity.uid)
            .toDocument();
        if (!value.exists) {
          resultCollectionRef.doc(resultuid).set(newAiResult);
        }
      });
      return;
  }

  // @override
  // Future<String> uploadPatientImage(String email, File image)async {
  //  final ref = firebaseStorage.ref().child("patientImage").child(email);
  //  await ref.putFile(image);
  //  final String downloadurl=await ref.getDownloadURL();
  //  return downloadurl;
  // }
}
