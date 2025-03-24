import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagement/route/route_name.dart';
import 'package:taskmanagement/view/auth/forgot_password_verify_email_screen.dart';
import 'package:taskmanagement/view/auth/sign_up_screen.dart';
import 'package:taskmanagement/view/widgets/bg_image.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child:SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 80,),
                  Text("Get Started With",style: Theme.of(context).textTheme.titleLarge,),

                  SizedBox(height: 25,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                  ),

                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                  ),

                  SizedBox(height: 16,),
                  ElevatedButton(onPressed:()=>Navigator.pushNamed(context, AppRoute.appBottomNavScreen), child: Icon(Icons.arrow_circle_right_outlined,color: Colors.white,)),

                  SizedBox(height: 32,),

                  Column(
                    children: [
                      TextButton(onPressed:_onTapForgotPasswordButton, child: Text("Forgot Password?")),

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

  void _onTapForgotPasswordButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordVerifyEmailScreen()));
  }

  void _onTapSignUpButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

}
