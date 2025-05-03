import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanagement/data/service/network_client_dart.dart';
import '../model/login_model.dart';
import '../utils/urls.dart';
import 'auth_controller.dart';

class UserAuthenticationController extends GetxController{


  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> mobileController = TextEditingController().obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
   bool _isSignUpProgress = false;
   bool _isLoginProgress = false;
   String? errorMessage;
   bool? get isSignUpProgress =>_isSignUpProgress;
   bool? get isLoginProgress=>_isLoginProgress;



  //Registration
  Future<bool> registerUser({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    required String password,})async{
    bool isSuccess = false;
    _isSignUpProgress = true;

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
    };
    final response = await NetworkClient.postRequest(
        url:Urls.registerUrl,
        body:requestBody
    );
    if(response.statusCode == 200){
      print("User SignUp success");
      isSuccess = true;
      errorMessage = null;

    }else{
      errorMessage = response.errorMessage;
    }
    _isSignUpProgress= false;
    update();

    return isSuccess;
  }



  //login
   Future<bool> userLogin({required String email,required String password})async{
    bool isSuccess = false;
     _isLoginProgress = true;
     update();
     Map<String, dynamic> requestBody ={
       "email":email,
       "password":password,
     };
     NetworkResponse response = await NetworkClient.postRequest(
       url: Urls.loginUrl,
       body: requestBody,
     );

     if(response.statusCode == 200){
       LoginModel loginModel = LoginModel.fromJson(response.data!);
       AuthController.saveUserInformation(loginModel.token, loginModel.userModel);
       print("User SignUp success");
       isSuccess = true;
       errorMessage = null;

     }else{
       errorMessage = response.errorMessage;
     }
     _isLoginProgress = false;
     update();
     return isSuccess;


   }




}