import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile/core/error/exception.dart';
import 'package:mobile/core/network/api_constant.dart';
import 'package:mobile/core/network/api_consumer.dart';
import 'package:mobile/core/network/api_iterceptors.dart';
import 'package:mobile/core/network/status_code.dart';
import 'package:mobile/injection_container.dart' as di;

class DioCosumer implements ApiConsumer {
  final Dio client;

  DioCosumer({required this.client}) {
    client.options
      ..baseUrl = ApiConstant.baseUrl
      ..responseType = ResponseType.plain
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    client.interceptors.add(di.sl<AppInterceptors>());
    if (kDebugMode) {
      client.interceptors.add(di.sl<LogInterceptor>());
    }
  }

  @override
  Future get(String path,
      {Map<String, dynamic>? queryParameters, String? token}) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      return _handleDioError(error);
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      String? token,
      bool? formDataIsEnabled}) async {
    try {
      final response = await client.post(path,
          data: body,
          queryParameters: queryParameters,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    final responseJson = json.decode(response.data.toString());
    return responseJson;
  }

  dynamic _handleDioError(DioException error) {
    if (error.type
        case DioExceptionType.connectionTimeout ||
            DioExceptionType.sendTimeout ||
            DioException.receiveTimeout) {
      throw const FetchDataException();
    } else if (error.type case DioExceptionType.values) {
      switch (error.response?.statusCode) {
        case StatusCode.badRequest:
          throw const BadRequestException();
        case StatusCode.unauthorized:
        case StatusCode.forbidden:
          throw const UnauthorizedException();
        case StatusCode.notFound:
          throw const NotFoundException();
        case StatusCode.confilct:
          throw const ConflictException();

        case StatusCode.internalServerError:
          throw const InternalServerErrorException();
      }
    } else if (error.type case DioExceptionType.cancel) {
    } else if (error.type case DioExceptionType.unknown) {
      throw const NoInternetConnectionException();
    } else if (error.type
        case DioExceptionType.receiveTimeout ||
            DioExceptionType.badCertificate) {}
  }

  @override
  Future delete(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      String? token,
      bool? formDataIsEnabled}) async {
    try {
      final response = await client.delete(path,
          data: body,
          queryParameters: queryParameters,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return _handleResponseAsJson(response);
    } on DioException catch (eror) {
      _handleDioError(eror);
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      String? token,
      bool? formDataIsEnabled}) async {
    try {
      final response = await client.put(path,
          data: body,
          queryParameters: queryParameters,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future postFile(String path,
      {bool? isFormData,
      Map<String, dynamic>? queryParameters,
      String? token,
      Map<String, dynamic>? formData}) async {
    try {
      final response = await client.post(path,
          data: isFormData! ? FormData.fromMap(formData!) : formData,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }
}
