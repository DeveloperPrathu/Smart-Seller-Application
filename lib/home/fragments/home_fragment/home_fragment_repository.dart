

import 'package:application/constants.dart';
import 'package:dio/dio.dart';

class HomeFragmentRepository {

  final Dio dio = Dio();

  Future<Response> categories() async {
    final response = await dio.get(BASE_URL + "/categories/",);
    return response;
  }

  Future<Response> slides() async {
    final response = await dio.get(BASE_URL + "/slides/",);
    return response;
  }
}