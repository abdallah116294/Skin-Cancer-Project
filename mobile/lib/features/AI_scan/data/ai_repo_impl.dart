import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mobile/core/network/ai_consumer.dart';
import 'package:mobile/core/network/api_constant.dart';
import 'package:mobile/features/AI_scan/data/ai_repo.dart';
import 'package:mobile/features/AI_scan/data/perediction_mode.dart';

class AIRepoImpl implements AIRepo {
  @override
  Future<Either<String, PeredictionModel>> peredectionSkinorNot(
      File image) async {
    try {
      final response = await DioHelper.postData(
          url: ApiConstant.skinornotModel,
          isFormData: true,
          data: {"image": await convertImageToBinary(image)});
      final predict = PeredictionModel.fromJson(response.data);
      return Right(predict);
    } on DioException catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, PeredictionModel>> peredectionTypeofCancer(
      File image) async {
    try {
      final response = await DioHelper.postData(
          url: ApiConstant.detectModel,
          isFormData: true,
          data: {"image": await convertImageToBinary(image)});
      final predict = PeredictionModel.fromJson(response.data);
      return Right(predict);
    } on DioException catch (error) {
      return Left(error.toString());
    }
  }

  Future convertImageToBinary(File image) async {
    List<int> imageBytes = await image.readAsBytes();
    return MultipartFile.fromBytes(imageBytes,
        filename: image.path.split('/').last);
  }
}
