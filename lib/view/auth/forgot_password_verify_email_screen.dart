import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagement/data/service/network_client_dart.dart';
import 'package:taskmanagement/data/utils/urls.dart';
import 'package:taskmanagement/view/auth/otp_screen.dart';
import 'package:taskmanagement/view/widgets/bg_image.dart';
import 'package:taskmanagement/view/widgets/snack_bar_message.dart';

class ForgotPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgotPasswordVerifyEmailScreen({super.key});

  @override
  State<ForgotPasswordVerifyEmailScreen> createState() => _ForgotPasswordVerifyEmailScreenState();
}

class _ForgotPasswordVerifyEmailScreenState extends State<ForgotPasswordVerifyEmailScreen> {
  final _emailTEController = TextEditingController();
  bool isEmailVerify = false;
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
                  ElevatedButton(onPressed:_onTapSubmitButton, child: Icon(Icons.arrow_circle_right_outlined)),

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
    isEmailVerify = true;
    setState(() {});
    final email = _emailTEController.text.trim();
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.recoverVerifyEmail(email));
    if(response.statusCode == 200){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen()

      ));
      
    }else{
      showSnackBarMessage(context, response.errorMessage,true);
    }
    isEmailVerify = false;
    setState(() {

    });

  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
  }
}
