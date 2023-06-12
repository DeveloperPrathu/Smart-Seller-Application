

import 'package:application/constants.dart';
import 'package:dio/dio.dart';

class ProductDetailsRepository {

  final Dio dio = Dio();

  Future<Response> loadDetails(productId) async {
    final response = await dio.get(BASE_URL + "/product_details/",
        queryParameters: {
          'productId': productId,
        });
    return response;
  }

}