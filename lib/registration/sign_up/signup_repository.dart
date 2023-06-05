

import 'package:application/constants.dart';
import 'package:dio/dio.dart';

class SignUpRepository {

  final Dio dio = Dio();

  Future<Response> requestOtp(email, phone) async {
    final response = await dio.post(BASE_URL + "/request_otp/", data: {
      'email': email,
      'phone': phone,
    });

    return response;
  }
}