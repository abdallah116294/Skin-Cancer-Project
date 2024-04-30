import 'package:flutter/material.dart';
import 'package:mobile/app/my_app.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(const MyApp());
}
