import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taskmanagement/data/service/network_client_dart.dart';
import 'package:taskmanagement/data/utils/urls.dart';
import 'package:taskmanagement/view/auth/reset_password_screen.dart';
import 'package:taskmanagement/view/widgets/bg_image.dart';
import 'package:taskmanagement/view/widgets/snack_bar_message.dart';

import 'login_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key,});


  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _pinCodeController = TextEditingController();
  bool isOtpVerify = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: ScreenBackground(
          child:SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  SizedBox(height: 80,),

                  Text("Pin Verification",style: Theme.of(context).textTheme.titleLarge,),
                  SizedBox(height: 5,),
                  Text("A 6 digit verification pin has been sent to your email",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),),

                  SizedBox(height: 24,),
                  PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    controller: _pinCodeController,
                    appContext: context,
                  ),

                  SizedBox(height: 16,),
                  ElevatedButton(onPressed: _onTapSubmitButton, child: Text("Verify")),

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
      ),
    );
  }
  void _onTapSubmitButton() {
    sendVerifyOtp();
  }
  void _onTapSignInButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (pre) => false,
    );
  }

  Future<void> sendVerifyOtp ()async{
    isOtpVerify = true;
    setState(() {

    });

    final otp = _pinCodeController.text;
    final email = "";
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.recoverVerifyOtp(email,otp));
    if(response.statusCode == 200){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ResetPasswordScreen()));
    }else{
      showSnackBarMessage(context, response.errorMessage,true);
    }
    isOtpVerify =false;
    setState(() {

    });

  }

  @override
  void dispose() {
    super.dispose();
    _pinCodeController.dispose();
  }

}
