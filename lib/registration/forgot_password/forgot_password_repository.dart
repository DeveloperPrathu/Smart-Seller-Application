

import 'package:application/constants.dart';
import 'package:dio/dio.dart';

class ForgotPasswordRepository {

  final Dio dio = Dio();

  Future<Response> reset_password(email) async {
    final response = await dio.post(BASE_URL + "/password_reset_email/", data: {
      'email': email,
    });

    return response;
  }
}