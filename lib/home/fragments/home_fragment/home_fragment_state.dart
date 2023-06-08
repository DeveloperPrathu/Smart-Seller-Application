import '../../../models/category_model.dart';
import '../../../models/slide_model.dart';

abstract class HomeFragmentState {}

class HomeFragmentInitial extends HomeFragmentState {}

class HomeFragmentLoading extends HomeFragmentState {}

class HomeFragmentLoaded extends HomeFragmentState {
  List<CategoryModel> categories;
  List<SlideModel> slides;

  HomeFragmentLoaded(this.categories, this.slides);
}

class HomeFragmentFailed extends HomeFragmentState {
  String message;

  HomeFragmentFailed(this.message);
}