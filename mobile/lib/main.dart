import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile/app/my_app.dart';
//import 'package:flutter_paymob/flutter_paymob.dart';
import 'package:mobile/core/network/dio_helper.dart';
import 'core/utils/string_manager.dart';
import 'firebase_options.dart';
import 'injection_container.dart'as di;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterPaymob.instance.initialize(
  //     apiKey: StringManager.paymobApiKey,
  //     iFrameID: 782498,
  //     walletIntegrationId: 4120104,integrationID:4443341 );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  DioHelper.initDio();
  await di.init();
  runApp(const MyApp());
}

