import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagement/data/service/network_client_dart.dart';
import 'package:taskmanagement/data/utils/urls.dart';
import 'package:taskmanagement/route/route_name.dart';
import 'package:taskmanagement/view/widgets/bg_image.dart';
import 'package:taskmanagement/view/widgets/snack_bar_message.dart';
import 'package:get/get.dart';

import '../../data/controller/user_authentication_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserAuthenticationController _userAuthController = Get.find<UserAuthenticationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                SizedBox(height: 80,),

                Text("Join With Us",style: Theme.of(context).textTheme.titleLarge,),

                SizedBox(height: 24,),

                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (String?value){
                    String email = value!.trim()??"";
                    if(EmailValidator.validate(email) == false){
                      return "Enter a valid email";
                    }
                    return null;

                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _firstNameTEController,
                  decoration: const InputDecoration(
                    hintText: 'First name',
                  ),
                  validator: (String?value){
                    if(value?.trim().isEmpty ?? true){
                      return "Enter your first name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _lastNameTEController,
                  decoration: const InputDecoration(
                    hintText: 'Last name',
                  ),
                  validator: (String?value){
                    if(value!.trim().isEmpty){
                      return "Enter your last name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  controller: _mobileTEController,
                  decoration: const InputDecoration(
                    hintText: 'Mobile',
                  ),
                  validator: (String? value){
                    String phone = value!.trim();
                    RegExp regExp = RegExp(r"^(?:\+?88|0088)?01[15-9]\d{8}$");
                    if(regExp.hasMatch(phone) == false){
                      return "Enter your valid phone";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordTEController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  validator: (String?value){
                    if((value!.isEmpty ?? true) ||(value.length<6)){
                      return "Enter your password more then 6 letters";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                GetBuilder<UserAuthenticationController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.isSignUpProgress == false,
                      replacement:  Center(child: CircularProgressIndicator(),),
                      child: ElevatedButton(
                        onPressed: _onTapSubmitButton,
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    );
                  }
                ),

                const SizedBox(height: 32),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      children: [
                        const TextSpan(text: "Already have an account? "),
                        TextSpan(
                          text: 'Sign In',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _onTapSignInButton,
                        ),
                      ],
                    ),
                  ),
                )



              ],
            ),
          ),
        ),
      ),
    );
  }

  //SignUp Button
  void _onTapSubmitButton(){
    if(_formKey.currentState!.validate()){
      _registerUser();
    }

  }

  //login button
  void _onTapSignInButton(){
    Navigator.pop(context);
  }

  //call api for Signup
  Future<void> _registerUser()async{
    final bool isSuccess = await _userAuthController.registerUser(
        email: _emailTEController.text.trim(),
        firstName: _firstNameTEController.text.trim(),
        lastName: _lastNameTEController.text.trim(),
        mobile: _mobileTEController.text.trim(),
        password:_passwordTEController.text.trim()
    );
    if(isSuccess){
      _clearTextFields();
      showSnackBarMessage(context, "User registered successfully!");
      Get.toNamed(AppRoute.loginScreen);
    }else{
      showSnackBarMessage(context, _userAuthController.errorMessage!,true);
    }

  }
  void _clearTextFields(){
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
  }
}

