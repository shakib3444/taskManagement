import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagement/data/controller/auth_controller.dart';
import 'package:taskmanagement/data/model/login_model.dart';
import 'package:taskmanagement/data/service/network_client_dart.dart';
import 'package:taskmanagement/view/app_bottom_navigation/screen/app_bottom_navigationbar.dart';
import 'package:taskmanagement/view/auth/forgot_password_verify_email_screen.dart';
import 'package:taskmanagement/view/auth/sign_up_screen.dart';
import 'package:taskmanagement/view/widgets/bg_image.dart';
import 'package:taskmanagement/view/widgets/snack_bar_message.dart';

import '../../data/utils/urls.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loginInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child:SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  SizedBox(height: 80,),
                  Text("Get Started With",
                    style: Theme.of(context).textTheme.titleLarge,),

                  SizedBox(height: 25,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                    validator: (String?value){
                      String email = value!.trim()??"";
                      if(EmailValidator.validate(email) == false){
                        return "Enter a valid Email";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                    validator: (String?value){
                      if((value?.isEmpty??true)||(value!.length<6)){
                        return "Enter your password more then 6 letter";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 16,),

                  Visibility(
                    visible: _loginInProgress == false,
                    replacement: CircularProgressIndicator.adaptive(),
                    child: ElevatedButton(
                        onPressed:(){
                          _onTapSignInButton();
                        },
                        child: Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Colors.white,),
                    ),
                  ),

                  SizedBox(height: 32,),

                  Column(
                    children: [
                      TextButton(
                          onPressed:_onTapForgotPasswordButton,
                          child: Text("Forgot Password?"),
                      ),

                      RichText(text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap=_onTapSignUpButton,
                          )
                        ]
                      ))
                    ],
                  )

                ],
              ),
            ),
          )
      ),
    );
  }

  //forgot Password button function
  void _onTapForgotPasswordButton(){
    Navigator.push(context, MaterialPageRoute(
        builder: (context)=>ForgotPasswordVerifyEmailScreen(),
    ),
    );
  }

  //Signup button function
  void _onTapSignUpButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  //login button function
  void _onTapSignInButton(){
    if(_formKey.currentState!.validate()){
      _login();
    }
  }

  //login  function
  Future<void> _login()async{
    _loginInProgress = true;
    setState((){});
      Map<String, dynamic> requestBody ={
        "email":_emailController.text.trim(),
        "password":_passwordController.text,
      };
      NetworkResponse response = await NetworkClient.postRequest(
          url: Urls.loginUrl,
          body: requestBody,
      );
      _loginInProgress = false;
        setState(() {});
      if(response.isSuccess){
        LoginModel loginModel = LoginModel.fromJson(response.data!);
        AuthController.saveUserInformation(loginModel.token, loginModel.userModel);
        dispose();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const AppBottomNavigationBar(),
          ),
              (predicate) => false,
        );
      }else{
        showSnackBarMessage(context, response.errorMessage,true);
      }


  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

}
