import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanagement/data/model/user_model.dart';
import 'package:get/get.dart';

class AuthController{
  static String? token;
  static UserModel? userModel;

  static const String _tokenKey ="token";
  static const String _userDataKey = "user-data";

  //save user information
  static Future saveUserInformation(String accessToken, UserModel user)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_tokenKey, accessToken);
    sharedPreferences.setString(_userDataKey, jsonEncode(user.toJson()));
    token = accessToken;
    userModel = user;
  }

  //get user information
  static Future<void> getUserInformation()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString(_tokenKey);
    String? savedUserModelString = pref.getString(_userDataKey);
    if(savedUserModelString != null){
      UserModel savedUserModel = UserModel.fromJson(jsonDecode(savedUserModelString));
      userModel = savedUserModel;
    }
    token = accessToken;
  }

  //Check if user already logged in
  static Future<bool> checkIfUserLoggedIn()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userAccessToken = pref.getString(_tokenKey);
    if(userAccessToken != null){
      await getUserInformation();
      return true;
    }
    return false;

  }

  static clearUserData()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    token = null;
    userModel = null;
  }

  //Registration  function
  // Future<void> registerUser()async{
  //   _registrationInProgress = true;
  //   setState(() {});
  //   Map<String, dynamic> requestBody = {
  //     "email": _emailTEController.text.trim(),
  //     "firstName": _firstNameTEController.text.trim(),
  //     "lastName": _lastNameTEController.text.trim(),
  //     "mobile": _mobileTEController.text.trim(),
  //     "password": _passwordTEController.text
  //   };
  //   NetworkResponse response = await NetworkClient.postRequest(
  //     url:Urls.registerUrl,
  //     body: requestBody,
  //   );
  //   _registrationInProgress = false;
  //   setState(() {});
  //   if(response.isSuccess){
  //     _clearTextFields();
  //     showSnackBarMessage(context, "User registered successfully!");
  //   }else{
  //     showSnackBarMessage(context, response.errorMessage,true);
  //   }
  //
  // }





}
