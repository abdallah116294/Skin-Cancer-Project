import 'package:flutter/material.dart';

class AppMethods{
  static Future<void> imagePickerDialog(
      {required BuildContext context,
        required Function camerFun,
        required Function galeryFun,
        required Function removeFun}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text("Chose option")),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextButton.icon(
                      onPressed: () {
                        camerFun();
                      },
                      icon: const Icon(Icons.camera),
                      label: const Text("Camera")),
                  TextButton.icon(
                      onPressed: () {
                        galeryFun();
                      },
                      icon: const Icon(Icons.file_open),
                      label: const Text("Galery")),
                  TextButton.icon(
                      onPressed: () {
                        removeFun();
                      },
                      icon: const Icon(Icons.remove),
                      label: const Text("remove"))
                ],
              ),
            ),
          );
        });
  }
}