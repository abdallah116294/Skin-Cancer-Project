import 'package:flutter/material.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/features/payments/screens/register_to_payment.dart';
class ReferenceScreen extends StatelessWidget {
  const ReferenceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reference Code'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              ///paymentExitApp(context);
              // Navigator.pushNamed(
              //   context,
              //   RootScreen.rootname
              // );

              ///
            },
            icon: const Icon(
              Icons.exit_to_app,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'You should go to any market to pay',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'This is reference code',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 30.0),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.purple.shade300,
                ),
                child: Center(
                  child: Text(
                    StringManager.refCode.isEmpty ? '🚫' : StringManager.refCode,
                    style: const TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void paymentExitApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Are you sure not completed the pay',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                navigateAndFinish(
                  context,
                  const RegisterPayment(),
                );
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => widget,
      ),
      (route) => false,
    );
