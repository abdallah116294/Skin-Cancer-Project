import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile/core/utils/text_styles.dart';
import 'package:mobile/core/widgets/validatort.dart';
import 'package:mobile/features/payments/cubit/cubit.dart';
import 'package:mobile/features/payments/cubit/state.dart';
import 'package:mobile/features/payments/screens/toggle_screen.dart';
import 'package:mobile/features/payments/widgets/button_widget.dart';
class RegisterPayment extends StatefulWidget {
  const RegisterPayment({super.key});
  static const rootName = "RegisterPayment";
  @override
  State<RegisterPayment> createState() => _RegisterPaymentState();
}

class _RegisterPaymentState extends State<RegisterPayment> {
  late final TextEditingController _fnameController;
  late final FocusNode _fnameFocusNode;
  late final TextEditingController _lnameController;
  late final FocusNode _lnameFocusNode;
  late final TextEditingController _emailController;
  late final FocusNode _emailFocusNode;
  late final TextEditingController _phoneController;
  late final FocusNode _phoneFocusNode;
  late final TextEditingController _priceController;
  late final FocusNode _priceNode;
  late final _formKey = GlobalKey<FormState>();
  
  //final cartProvider=Provider.of(context);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fnameController = TextEditingController();
    _fnameFocusNode = FocusNode();
    _lnameController = TextEditingController();
    _lnameFocusNode = FocusNode();
    _emailController = TextEditingController();
    _emailFocusNode = FocusNode();
    _phoneController = TextEditingController();
    _phoneFocusNode = FocusNode();
    _priceController = TextEditingController();
    _priceNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fnameController.dispose();
    _fnameFocusNode.dispose();
    _lnameController.dispose();
    _lnameFocusNode.dispose();
    _emailController.dispose();
    _emailFocusNode.dispose();
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    _priceController.dispose();
    _priceNode.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (context) => PaymentCubit()..getAuthToken(),
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Payment Integration"),
            ),
            body: BlocConsumer<PaymentCubit, PaymentStates>(
              listener: (context, state) {
                // if (state is PaymentOrderIdSuccessStates) {
                //   Fluttertoast.showToast(msg: AppConstant.paymentOrderId);
                // }
                if (state is PaymentRequestTokenSuccessStates) {
                  Fluttertoast.showToast(msg: "success get final Token");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ToggleScreen()));
                }
              },
              builder: (context, state) {
                var cubit = PaymentCubit.get(context);
                return SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(
                      height: 30,
                    ), 
                     Text(
                       "Let's Strat Pay for product ",style: TextStyles.font24PrimaryW700,),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //frist name
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    controller: _fnameController,
                                    focusNode: _fnameFocusNode,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                      hintText: "First name",
                                      prefixIcon: Icon(
                                        Icons.message,
                                      ),
                                    ),
                                    validator: (value) {
                                      return MyValidators.displayNamevalidator(
                                          value);
                                    },
                                    onFieldSubmitted: (value) {
                                      FocusScope.of(context)
                                          .requestFocus(_lnameFocusNode);
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                //late name
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    controller: _lnameController,
                                    focusNode: _lnameFocusNode,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                      hintText: "last name",
                                      prefixIcon: Icon(
                                        Icons.message,
                                      ),
                                    ),
                                    validator: (value) {
                                      return MyValidators.displayNamevalidator(
                                          value);
                                    },
                                    onFieldSubmitted: (value) {
                                      FocusScope.of(context)
                                          .requestFocus(_emailFocusNode);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            //emial
                            TextFormField(
                              controller: _emailController,
                              focusNode: _emailFocusNode,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: "Email address",
                                prefixIcon: Icon(
                                  Icons.message,
                                ),
                              ),
                              validator: (value) {
                                return MyValidators.emailValidator(value);
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_phoneFocusNode);
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            //phone
                            TextFormField(
                              controller: _phoneController,
                              focusNode: _phoneFocusNode,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                hintText: "Phone",
                                prefixIcon: Icon(Icons.phone),
                              ),
                              validator: (value) {
                                return null;

                                //  return MyValidators.emailValidator(value);
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(_priceNode);
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            //price
                            TextFormField(
                              controller: _priceController,
                              focusNode: _priceNode,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                hintText: "Price",
                                prefixIcon: Icon(Icons.attach_money),
                              ),
                              validator: (value) {
                                return null;

                                //  return MyValidators.emailValidator(value);
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            //button of register
                            const SizedBox(
                              height: 16.0,
                            ),
                            DefaultButton(
                              buttonWidget:
                                  state is! PaymentRequestTokenLoadingStates
                                      ? const Text(
                                          'Register',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            letterSpacing: 1.6,
                                          ),
                                        )
                                      : const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                              function: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.getOrderRegistrationId(
                                      email: _emailController.text,
                                      fname: _fnameController.text,
                                      lname: _lnameController.text,
                                      phone: _phoneController.text,
                                      price: _priceController.text);
                                  // Fluttertoast.showToast(
                                  //     msg: AppConstant.paymentFirstToken);
                                }
                              },
                              width: MediaQuery.of(context).size.width,
                              radius: 10.0,
                              backgroundColor: Colors.purple.shade300,
                            ),
                          ],
                        ))
                  ]),
                );
              },
            )));
  }
}
