import 'package:application/models/product_details_model.dart';
import 'package:application/product_details/product_details_repository.dart';
import 'package:application/product_details/product_details_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this.productId) : super(ProductDetailsInitial()){
   loadDetails();
  }
  String productId;

  ProductDetailsRepository _repository = ProductDetailsRepository();

  void loadDetails(){
    emit(ProductDetailsLoading());
    _repository.loadDetails(productId)
    .then((response){
      emit(ProductDetailsLoaded(ProductDetailsModel.fromJson(response.data)));
    }).catchError((value) {
      DioError error = value;
      if (error.response != null) {
        try {
          emit(ProductDetailsFailed(error.response!.data));
        } catch (e) {
          emit(ProductDetailsFailed(error.response!.data['detail']));
        }
      } else {
        if (error.type == DioErrorType.other) {
          emit(ProductDetailsFailed("Please check your internet connection!"));
        } else {
          emit(ProductDetailsFailed(error.message));
        }
      }
    });
  }
}