import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile/core/utils/extention.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/features/payments/cubit/cubit.dart';
import 'package:mobile/features/payments/cubit/state.dart';
import 'package:mobile/features/payments/screens/ref_code_screen.dart';
import 'package:mobile/features/payments/screens/visa_screen.dart';
import 'package:provider/provider.dart';
// import 'package:tijara/constent/app_constant.dart';
// import 'package:tijara/feature/payments/cubit/cubit.dart';
// import 'package:tijara/feature/payments/cubit/state.dart';
// import 'package:tijara/feature/payments/screens/ref_code_screen.dart';
// import 'package:tijara/feature/payments/screens/visa_screen.dart';

// import '../../../provider/payment_provider.dart';

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({super.key});
  static const rootName = "ToggleScreen";

  @override
  Widget build(BuildContext context) {
    //  final paymentProvider = Provider.of<PaymentProvider>(context);

    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: SafeArea(
          child: BlocConsumer<PaymentCubit, PaymentStates>(
        listener: (context, state) {
          if (state is PaymentRefCodeSuccessStates) {
            Fluttertoast.showToast(msg: "success to get ref code");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ReferenceScreen()));
          }
          if (state is PaymentRefCodeErrorStates) {
            Fluttertoast.showToast(msg: 'error to get refcode');
          }
        },
        builder: (context, state) {
          var cubit = PaymentCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("Toggle Screen"),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      log("final Token${StringManager.finalToken}baseApiPayment${StringManager.baseApiPayment}");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VisaScreen()));
                      // Navigatpr.pushNamed(routeName)
                      //navigateAndFinish(context, const VisaScreen());
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black, width: 2)),
                      child: Image.network(StringManager.visaImage),
                    ),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: InkWell(
                    onTap: () async {
                      cubit.getRefCode();
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black, width: 2)),
                      child: Image.network(StringManager.refCodeImage),
                    ),
                  )),
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}
