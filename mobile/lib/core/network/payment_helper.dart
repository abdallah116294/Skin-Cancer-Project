import 'package:dio/dio.dart';
import 'package:mobile/core/utils/string_manager.dart';
class PaymentHelper {
  static late Dio dio;
  static initDio() {
    dio = Dio(BaseOptions(
        baseUrl: StringManager.baseApiPayment,
        headers: {"Content-Type": 'application/json'},
        receiveDataWhenStatusError: true
        )
        
        );
  }
  static Future<Response> getData(
      {required String url, Map<String, dynamic>? query}) async {
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {required String url,
      required Map<String, dynamic>? data,
      Map<String, dynamic>? query}) async {
    return await dio.post(url, data: data, queryParameters: query);
  }
}