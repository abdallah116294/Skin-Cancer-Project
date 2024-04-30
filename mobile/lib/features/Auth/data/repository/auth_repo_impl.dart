import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/exception.dart';
import 'package:mobile/core/network/api_constant.dart';
import 'package:mobile/core/network/api_consumer.dart';
import 'package:mobile/features/Auth/data/model/user_model.dart';
import 'package:mobile/features/Auth/data/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiConsumer apiConsumer;
  AuthRepoImpl({required this.apiConsumer});
  @override
  Future<Either<String, UserModel>> loginUser(
      String email, String password) async {
    try {
      final respons = await apiConsumer.post(ApiConstant.loginEndPoint,
          body: {"email": email, "password": password});
      final user = UserModel.fromJson(respons);
      return Right(user);
    } on ServerException catch (error) {
      //log(error.toString());
      String logineror = error.toString();
      log('repo error$logineror');
      return Left(logineror);
    }
  }
}
