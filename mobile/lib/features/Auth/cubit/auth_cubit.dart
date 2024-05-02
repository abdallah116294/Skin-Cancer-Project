import 'dart:developer';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/widgets/error_text_widgte.dart';
import 'package:mobile/features/Auth/data/model/add_role_respons.dart';
import 'package:mobile/features/Auth/data/model/user_model.dart';
import 'package:mobile/features/Auth/data/repository/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepo}) : super(AuthInitial());
  AuthRepo authRepo;
  String autherror = '';

  Future<void> userlogin(String email, String password) async {
    emit(LoginUserIsLoadingState());
    try {
      Either<String, UserModel> response =
          await authRepo.loginUser(email, password);
      response.fold((left) {
        autherror = extractErrorMessage(left);
        emit(LoginUserIsErrorState(error: autherror));
      }, (r) => emit(LoginUserIsSuccessSetate(userModel: r)));
    } on FormatException catch (error) {
      String errormessge = error.toString();
      autherror = extractErrorMessage(errormessge);
      ;
      emit(LoginUserIsErrorState(error: autherror));
    } catch (error) {
      String errormessage = error.toString();
      autherror = extractErrorMessage(errormessage);
      emit(LoginUserIsErrorState(error: autherror));
    }
  }

  Future<void> userRegister(
      {required String email,
      required String password,
      required String firstname,
      required String lastname,
      required String phoneNumber,
      required String userName}) async {
    emit(RegisterUserIsLoadingState());
    try {
      Either<String, String> response = await authRepo.registerUser(
          firstname: firstname,
          lastname: lastname,
          phoneNumber: phoneNumber,
          email: email,
          userName: userName,
          password: password);
      response.fold((left) {
        emit(RegisterUserIsErrorState(error: extractErrorMessage(left)));
      }, (r) => emit(RegisterUserIsSuccessSetate(message: r)));
    } catch (error) {
      emit(RegisterUserIsErrorState(
          error: extractErrorMessage(error.toString())));
    }
  }

 Future<void>addRole(String roleName,String userName)async{
  try{
     Either<String,AddRoleRespons>response=await authRepo.addRole(roleName, userName);
     emit(response.fold((l) => AddRoleErrorState(error: extractErrorMessage(l)), (r) =>AddRoleSuccesState(respons: r) ));
  }catch(error){
    emit(AddRoleErrorState(error: extractErrorMessage(error.toString())));
  }
 }
  String extractErrorMessage(String errorString) {
    // Split the errorString by newline characters
    List<String> lines = errorString.split('\n');
    // Iterate through the lines to find the error message
    for (int i = 0; i < lines.length; i++) {
      // Check if the line contains the error message
      if (lines[i].contains("FormatException")) {
        // Return the next line as the error message
        if (i + 1 < lines.length) {
          return lines[i + 1];
        }
      }
    }
    // If no error message is found, return the original error string
    return errorString;
  }

  Widget showErrorText() {
    return ErrorTextWidget(errormessage: autherror);
  }
}
