import 'package:get/get.dart';

import '../service/network_client_dart.dart';
import '../utils/urls.dart';


class UserForgotPasswordController extends GetxController{
  bool _isEmailVerify = false;
  bool _isOTPVerify = false;
  bool _isResetPassword = false;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  bool? get isEmailVerify => _isEmailVerify;
  bool? get isOTPVerify => _isOTPVerify;
  bool? get isResetPassword => _isResetPassword;

  Future<bool> emailVerify({required String email})async{
    bool isEmailVerify = false;
    _isEmailVerify = true;
    update();
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.recoverVerifyEmail(email));
    if(response.statusCode == 200){
      print("Email verify success");
      isEmailVerify = true;
      _errorMessage = null;
    }else{
      _errorMessage = response.errorMessage;
    }
    _isEmailVerify =false;
    update();
    return isEmailVerify;
  }

  Future<bool> sendVerifyOtp ({required String otp,required String email})async{
    bool isOTPSuccess = false;

    _isOTPVerify = true;
    update();
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.recoverVerifyOtp(email,otp));
    if(response.statusCode == 200){
      print("OTP verify success");
      isOTPSuccess = true;
      _errorMessage = null;
    }else{
      _errorMessage = response.errorMessage;
    }
    _isOTPVerify =false;
    update();
    return isOTPSuccess;

  }
  Future<bool> resetPassword ({
    required String otp,
    required String email,
    required String password,
  })async{
    bool isResetPassword = false;

    _isResetPassword = true;
    update();
    Map<String, dynamic> requestBody ={
      "email":email,
      "OTP": otp,
      "password":password,

    };
    final NetworkResponse response = await NetworkClient.postRequest(
        url: Urls.recoverResetPassword,
      body: requestBody,
    );
    if(response.statusCode == 200){
      print("ResetPassword success");
      isResetPassword = true;
      _errorMessage = null;
    }else{
      _errorMessage = response.errorMessage;
    }
    _isResetPassword =false;
    update();
    return isResetPassword;

  }

}