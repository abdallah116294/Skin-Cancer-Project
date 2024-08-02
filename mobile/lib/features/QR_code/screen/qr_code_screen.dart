import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/widgets/custom_dailog.dart';
import 'package:mobile/features/clinic/cubit/clinic_cubit.dart';
import 'package:mobile/features/clinic/data/model/selected_clinic_model.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mobile/injection_container.dart' as di;

class QrCodeScanner extends StatefulWidget {
  QrCodeScanner({
    required this.setResult,
    required this.selectedClinicModel,
    super.key,
  });

  final Function setResult;
  final List<SelectedClinicModel> selectedClinicModel;

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  final MobileScannerController controller = MobileScannerController();
  String? _result;
  void setResult(String result) {
    setState(() => _result = result);
    log(_result.toString());
  }

  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Match Found'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var clinicid = CacheHelper.getData(key: 'clinic_id');
    return Stack(
      children: [
        MobileScanner(
          controller: controller,
          onDetect: (BarcodeCapture capture) async {
            final List<Barcode> barcodes = capture.barcodes;
            final barcode = barcodes.first;

            if (barcode.rawValue != null) {
              widget.setResult(barcode.rawValue);
              setResult(barcode.rawValue.toString());
              // var inApppointmnet = widget.selectedClinicModel
              //     .where((element) => element.patientId == _result);

              var inApppointmnet = widget.selectedClinicModel
                  .where((element) => element.patientId == _result);
              if (inApppointmnet.isNotEmpty) {
                DailogAlertFun.showMyDialog(
                    daliogContent: 'Correct Appointment',
                    actionName: 'Go Back',
                    context: context,
                    onTap: () {
                      context.pushNamedAndRemoveUntil(Routes.bottomNavScreenRoutes,
                    predicate: (Route<dynamic> route) => false);
                    });
              }
              else
                {
                  DailogAlertFun.showMyDialog(
                    isSuccess: false,
                      daliogContent: 'Invalid Appointment',
                      actionName: 'Go Back',
                      context: context,
                      onTap: () {
                        context.pushNamedAndRemoveUntil(Routes.bottomNavScreenRoutes,
                            predicate: (Route<dynamic> route) => false);
                      });
                }
            }
          },
        ),
      ],
    );
  }
}
