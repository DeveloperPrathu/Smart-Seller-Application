

import 'package:application/constants.dart';
import 'package:application/registration/login/login_repository.dart';
import 'package:application/registration/login/login_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit() : super(LoginInitial());

  LoginRepository _repository = LoginRepository();

  void login(email_phone, password){
    String? email, phone;
    emit(LoginSubmitting());
    if(RegExp(EMAIL_REGEX).hasMatch(email_phone)){
      email = email_phone;
    }else{
      phone = email_phone;
    }

    _repository.login(email, phone, password)
    .then((response){
      emit(LoginSuccess(response.data));
    }).catchError((value){
      DioError error = value;
      if(error.response != null){
        try{
          emit(LoginFailed(error.response!.data));
        }catch(e){
          emit(LoginFailed(error.response!.data['detail']));
        }
      }else{
        if(error.type == DioErrorType.other){
          emit(LoginFailed("Please check your internet connection!"));
        }else{
          emit(LoginFailed(error.message));
        }
      }
    });
  }
}