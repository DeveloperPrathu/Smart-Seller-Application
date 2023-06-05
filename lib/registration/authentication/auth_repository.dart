

import 'dart:io';

import 'package:application/constants.dart';
import 'package:dio/dio.dart';

class AuthRepository {

  final Dio dio = Dio();

  Future<Response> getUserData({required String token}) async {
    final response = await dio.get(BASE_URL+"/userdata/", options: Options(headers: {HttpHeaders.authorizationHeader:token}));
    return response;
  }

}