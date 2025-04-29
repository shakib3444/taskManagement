import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagement/data/controller/user_forgot_password_controller.dart';
import 'package:taskmanagement/data/service/network_client_dart.dart';
import 'package:taskmanagement/data/utils/urls.dart';
import 'package:taskmanagement/route/route_name.dart';
import 'package:taskmanagement/view/auth/otp_screen.dart';
import 'package:taskmanagement/view/widgets/bg_image.dart';
import 'package:taskmanagement/view/widgets/snack_bar_message.dart';
import 'package:get/get.dart';
class ForgotPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgotPasswordVerifyEmailScreen({super.key});

  @override
  State<ForgotPasswordVerifyEmailScreen> createState() => _ForgotPasswordVerifyEmailScreenState();
}

class _ForgotPasswordVerifyEmailScreenState extends State<ForgotPasswordVerifyEmailScreen> {
  final _emailTEController = TextEditingController();
  final UserForgotPasswordController forgotController = Get.find<UserForgotPasswordController>();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child:SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  SizedBox(height: 80,),

                  Text("Your Email Address",style: Theme.of(context).textTheme.titleLarge,),
                  SizedBox(height: 5,),
                  Text("A 6 digit verification pin will be sent to your email",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),),
                  SizedBox(height: 16,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTEController,
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
                  SizedBox(height: 15,),
                  GetBuilder<UserForgotPasswordController>(
                    builder: (controller) {
                      return Visibility(
                        visible:controller.isEmailVerify == false ,
                        replacement: Center(child: CircularProgressIndicator(),),
                        child: ElevatedButton(
                            onPressed:_onTapSubmitButton,
                            child: Icon(Icons.arrow_circle_right_outlined)),
                      );
                    }
                  ),

                  SizedBox(height: 32,),
                  Center(
                    child: RichText(text: TextSpan(
                      style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600,fontSize: 14),
                      children: [
                        TextSpan(text: "Have account?"),
                        TextSpan(text: 'Sign In',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton,
                        )
                      ]
                    ),
                    ),
                  ),

                ],
              ),
            ),
          ),
      ),
    );
  }
  void _onTapSubmitButton(){
    emailVerity();
  }

  void _onTapSignInButton(){
    Navigator.pop(context);
  }

  Future<void> emailVerity()async{
    bool isSuccess = await forgotController.emailVerify(email:_emailTEController.text.trim());
    if(isSuccess){
      Get.snackbar("Success", "Email Verify Success",backgroundColor: Colors.green,snackPosition:SnackPosition.BOTTOM);
      Get.toNamed(AppRoute.verifyOtpScreen,arguments: _emailTEController.text);
      _emailTEController.clear();
    }else{
      showSnackBarMessage(context, forgotController.errorMessage!,true);
    }


  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
  }
}
