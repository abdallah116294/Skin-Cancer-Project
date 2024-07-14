import 'package:flutter/material.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/app_color.dart';

class AppMethods {
  static Future<void> imagePickerDialog(
      {required BuildContext context,
      required Function camerFun,
      required Function galeryFun,
      required Function removeFun}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Center(child: Text("Choose option")),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextButton.icon(
                      onPressed: () {
                        camerFun();
                      },
                      icon:
                          Icon(color: AppColor.primaryColor, Icons.camera_alt),
                      label: const Text(
                        "Camera",
                        style: TextStyle(color: Colors.black),
                      )),
                  TextButton.icon(
                      onPressed: () {
                        galeryFun();
                      },
                      icon: Icon(color: AppColor.primaryColor, Icons.photo),
                      label: const Text(
                        "Gallery",
                        style: TextStyle(color: Colors.black),
                      )),
                  TextButton.icon(
                      onPressed: () {
                        removeFun();
                      },
                      icon: Icon(color: AppColor.primaryColor, Icons.delete),
                      label: const Text(
                        "remove",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
            ),
          );
        });
  }
}
