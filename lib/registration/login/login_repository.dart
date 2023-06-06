

import 'package:application/constants.dart';
import 'package:dio/dio.dart';

class LoginRepository {

  final Dio dio = Dio();

  Future<Response> login(email, phone, password) async {
    final response = await dio.post(BASE_URL + "/login/", data: {
      'email': email,
      'phone': phone,
      'password': password,
    });

    return response;
  }
}