import 'package:dio/dio.dart';
import 'package:mobile/core/network/api_constant.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl:ApiConstant.aiBasUrl,
      headers: {'Content-Type': 'application/json'},
    ));
    dio.interceptors.add(
        LogInterceptor(requestBody: true, error: true, responseBody: true));
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    bool isFormData = false,
  }) async {
    return await dio.post(
      url,
      queryParameters: {'ln': 'en'},
      data: isFormData ? FormData.fromMap(data) : data,
    );
  }
}