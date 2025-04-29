import 'package:get/get.dart';
import 'package:taskmanagement/data/service/network_client_dart.dart';

import '../model/login_model.dart';
import '../utils/urls.dart';
import 'auth_controller.dart';

class UserAuthenticationController extends GetxController{
   bool _isSignUpProgress = false;
   bool _isLoginProgress = false;
  String? _errorMessage;

  bool? get isSignUpProgress => _isSignUpProgress;
  bool? get isLoginProgress => _isLoginProgress;
  String? get errorMessage => _errorMessage;


  //Registration
  Future<bool> registerUser({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    required String password
  })async{
    bool isSuccess = false;

    _isSignUpProgress = true;
    update();
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
      _errorMessage = null;

    }else{
      _errorMessage = response.errorMessage;
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
       _errorMessage = null;

     }else{
       _errorMessage = response.errorMessage;
     }
     _isLoginProgress = false;
     update();
     return isSuccess;


   }




}