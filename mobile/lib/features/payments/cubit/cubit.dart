
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/network/dio_helper.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/features/payments/cubit/state.dart';
import 'package:mobile/features/payments/modesl/authentication_request_model.dart';
import 'package:mobile/features/payments/modesl/oreder_registeration_model.dart';
import 'package:mobile/features/payments/modesl/payment_request_model.dart';
// import 'package:tijara/feature/payments/cubit/state.dart';
// import '../../../constent/app_constant.dart';
// import '../../../core/network/dio_helper.dart';
// import '../../../models/authentication_request_model.dart';
// import '../../../models/oreder_registeration_model.dart';
// import '../../../models/payment_request_model.dart';

class PaymentCubit extends Cubit<PaymentInitialStates> {
  //PaymentCubit(super.initialState);
  PaymentCubit() : super(PaymentInitialStates());
  static PaymentCubit get(context) => BlocProvider.of(context);
  AuthenticationRequestModel? authenticationRequestModel;
  OrderRegisterationModel? orderRegisterationModel;
  PaymentRequsetModel? paymentRequsetModel;
  Future<void> getAuthToken() async {
    emit(PaymentAuthLoadingStates()); 
    await DioHelper.postData(
        url: StringManager.getAuthToken,
        data: {"api_key": StringManager.paymentAPIkey}).then((value) {
      StringManager.paymentFirstToken = value.data['token'];
      // authenticationRequestModel =
      //     AuthenticationRequestModel.formJson(value.data);
      // StringManager.paymentFirstToken = authenticationRequestModel!.token;
      emit(PaymentAuthSuccessStates());
    }).catchError((onError) {
      print("Error in Auth token ${onError.toString()}");
      emit(PaymentAuthErrorStates(onError.toString()));
    });
  }

  Future getOrderRegistrationId({
    required String fname,
    required String lname,
    required String email,
    required String phone,
    required String price,
  }) async {
    emit(PaymentOrderIdLoadingStates());
    await DioHelper.postData(url: StringManager.getOrderId, data: {
      "auth_token": StringManager.paymentFirstToken,
      "delivery_needed": "false",
      "amount_cents": price,
      "currency": "EGP",
      "items": [],
    }).then((value) {
      StringManager.paymentOrderId = value.data["id"].toString();
      // orderRegisterationModel = OrderRegisterationModel.fromJson(value.data);
      // StringManager.paymentOrderId =
      //     orderRegisterationModel!.id.toString() as int;
     getPaymentRequest(
            email: email,
            fname: fname,
            lname: lname,
            phone: phone,
            price: price);
      emit(PaymentOrderIdSuccessStates());
    }).catchError((error) {
      print("Error in order id ${error.toString()}");
      emit(PaymentOrderIdErrorStates(error.toString()));
    });
  }

  Future<void> getPaymentRequest({
    required String fname,
    required String lname,
    required String email,
    required String phone,
    required String price,
  }) async {
    emit(PaymentRequestTokenLoadingStates());
    await DioHelper.postData(url: StringManager.paymentKeyRequeset, data: {
      "auth_token": StringManager.paymentFirstToken,
      "amount_cents": price,
      "expiration": 3600,
      "order_id": StringManager.paymentOrderId,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": fname,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": lname,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": StringManager.paymentIntegrationCardId,
      "lock_order_when_paid": "false"
    }).then((value) {
      StringManager.finalToken = value.data["token"];
      // paymentRequsetModel = PaymentRequsetModel.fromJson(value.data);
      // StringManager.finalToken = paymentRequsetModel!.token;
      emit(PaymentRequestTokenSuccessStates());
    }).catchError((error) {
      print("error in request token ${error.toString()}");
      emit(PaymentRequestTokenErrorStates(error.toString()));
    });
  }

  Future<void> getRefCode() async {
    emit(PaymentRefCodeLoadingStates());
    DioHelper.postData(url: StringManager.getRefCode, data: {
      "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
      "payment_token": StringManager.finalToken
    }).then((value) {
      StringManager.refCode = value.data["id"].toString();
      emit(PaymentRefCodeSuccessStates());
    }).catchError((error) {
      print("error in get refcode ${error.toString()}");
      emit(PaymentRefCodeErrorStates(error.toString()));
    });
  }
}
