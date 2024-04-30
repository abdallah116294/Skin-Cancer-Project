import 'package:dartz/dartz.dart';
import 'package:mobile/features/Auth/data/model/user_model.dart';

abstract class AuthRepo{
  Future<Either<String,UserModel>>loginUser(String email,String password);

}