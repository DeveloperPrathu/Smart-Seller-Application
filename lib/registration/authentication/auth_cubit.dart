import 'package:application/constants.dart';
import 'package:application/models/user_model.dart';
import 'package:application/registration/authentication/auth_repository.dart';
import 'package:application/registration/authentication/auth_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthCubit extends Cubit<AuthState> {
  static String token = '';
  AuthRepository authRepository;
  final FlutterSecureStorage storage;

  AuthCubit({required this.storage, required this.authRepository})
      : super(AuthInitial());

  Future<AuthState> authenticate() async {
    AuthState newState;
    if (token.isEmpty) {
      try {
        var tokenValue = await _getToken();
        if (tokenValue == null) {
          newState = LoggedOut();
          emit(newState);
        } else {
          token = tokenValue;
          newState = await _fetchUserData();
        }
      } catch (e) {
        newState = LoggedOut();
        emit(newState);
      }
    } else {
      newState = await _fetchUserData();
    }
    return newState;
  }

  Future<AuthState> _fetchUserData() async {
    AuthState newState;
    try {
      var response = await authRepository.getUserData(token: token);
      newState = Authenticated(UserModel.fromJson(response.data));
      emit(newState);
    } catch (value) {
      DioError error = value as DioError;
      if (error.response != null) {
        newState = await removeToken();
      } else {
        if (error.type == DioErrorType.other) {
          newState =
              AuthenticationFailed("Please check your internet connection!");
          emit(newState);
        } else {
          newState = AuthenticationFailed(error.message);
          emit(newState);
        }
      }
    }
    return newState;
  }

  Future<String> updateWishlist(String id,String action) async {
    String result = SUCCESS;
    await authRepository.updateWishlist(id: id,action: action).then((response){
      if(action==ADD) {
        (state as Authenticated).userdata.wishlist!.add(id);
      }else if(action == REMOVE){
        (state as Authenticated).userdata.wishlist!.remove(id);
      }
    }).catchError((value) async {
      DioError error = value;
      if (error.response != null) {
        try {

          if(error.response!.data['detail'] == UNAUTHENTICATED_USER){
            await removeToken();
            emit(LoggedOut());
            result = FAILED;
          }
        } catch (e) {
          if(error.response!.data == UNAUTHENTICATED_USER){
            await removeToken();
            emit(LoggedOut());
            result = FAILED;
          }
        }
      }
    });
    return result;
  }

  Future<String> updateCart(String id,String action) async {
    String result = SUCCESS;
    await authRepository.updateCart(id: id,action: action).then((response){
      if(action==ADD) {
        (state as Authenticated).userdata.cart!.add(id);
      }else if(action == REMOVE){
        (state as Authenticated).userdata.cart!.remove(id);
      }
    }).catchError((value) async {
      DioError error = value;
      if (error.response != null) {
        try {
          if(error.response!.data['detail'] == UNAUTHENTICATED_USER){
            await removeToken();
            emit(LoggedOut());
            result = FAILED;
          }
        } catch (e) {
          if(error.response!.data == UNAUTHENTICATED_USER){
            await removeToken();
            emit(LoggedOut());
            result = FAILED;

          }
        }
      }
    });
    return result;
  }

  void loggedIn(String tokenValue) {
    emit(Authenticating());
    token = tokenValue;
    _setToken(token).then((value) => _fetchUserData());
  }

  Future<AuthState> removeToken() async {
    AuthState newState;
    token = '';
    try {
      await _deleteToken();
    } catch (e) {
      // nothing
    }

    newState = LoggedOut();
    emit(newState);
    return newState;
  }

  Future<void> _setToken(token) async {
    await storage.write(key: "token", value: token);
  }

  Future<String?> _getToken() async {
    String? value = await storage.read(key: "token");
    return value;
  }

  Future<void> _deleteToken() async {
    await storage.delete(key: "token");
  }
}
