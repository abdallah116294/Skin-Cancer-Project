import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'api_constant.dart';

class DioHepler {
  final Dio _dio;
  DioHepler(this._dio);
  Future<Map<String, dynamic>> getCategory(
    String country,
    String category
  ) async {
    try {
      var response =
          await _dio.get(APIKey.baserUrl + APIKey.url, queryParameters: {
        "apiKey": APIKey.apiKey,
        // "q":"Gaza",
        "country": country,
        "category": category,
        //"sources":"bbc-news"
      });
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        // debugPrint(response.data.toString());
        return response.data;
      } else {
        debugPrint("Request Faild with status code:${response.statusCode}");
        throw Exception(
            "Request Faild with status code:${response.statusCode}");
      }
    } catch (error) {
      debugPrint("Error:$error");
      throw Exception("Error:$error");
    }

    //return response.data;
  }
    Future<Map<String, dynamic>> getSearchItems(
      String item,
    ) async {
    try {
      var response =
          await _dio.get(APIKey.baserUrl + APIKey.everyThing, queryParameters: {
        "apiKey": APIKey.apiKey,
         "q":item,
      });
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        // debugPrint(response.data.toString());
        return response.data;
      } else {
        debugPrint("Request Faild with status code:${response.statusCode}");
        throw Exception(
            "Request Faild with status code:${response.statusCode}");
      }
    } catch (error) {
      debugPrint("Error:$error");
      throw Exception("Error:$error");
    }

    //return response.data;
  }
}
//https://newsapi.org/v2/everything?q=keyword&apiKey=847d8a876ced4a42913fe1b7e197d512
//https://newsapi.org/v2/everything?q=keyword&apiKey=d26c565c0d734f1f91d71df7cf239916