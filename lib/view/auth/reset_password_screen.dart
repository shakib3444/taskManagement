import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagement/data/controller/user_forgot_password_controller.dart';
import 'package:taskmanagement/view/widgets/bg_image.dart';
import 'package:taskmanagement/view/widgets/snack_bar_message.dart';
import 'package:get/get.dart';
import '../../route/route_name.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key,});


  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordTEController = TextEditingController();
  final TextEditingController _confirmNewPasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserForgotPasswordController forgotController = Get.find<UserForgotPasswordController>();
  final String email = Get.arguments["email"];
  final String otp = Get.arguments["otp"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                const SizedBox(height: 80),
                Text(
                  'Set Password',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Set a new password minimum length of 6 letters.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _newPasswordTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'New Password',
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Confirm New Password',
                  ),
                ),
                const SizedBox(height: 16),
                GetBuilder<UserForgotPasswordController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.isResetPassword == false,
                      replacement: Center(child: CircularProgressIndicator(),),
                      child: ElevatedButton(
                        onPressed: _onTapSubmitButton,
                        child: const Text('Confirm'),
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
                        const TextSpan(text: "Have account? "),
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
   _onTapSubmitButton() {
    resetPassword();


  }

  void _onTapSignInButton() {
    Get.offNamed(AppRoute.signupScreen);
  }

  Future<void> resetPassword ()async{
    bool isSuccess = await forgotController.resetPassword(otp: otp, email:email, password:_newPasswordTEController.text);
    if(isSuccess){
      showSnackBarMessage(context, "Reset Password Success");
      Get.offNamed(AppRoute.loginScreen);
    }else{
      showSnackBarMessage(context, forgotController.errorMessage!,true);
    }

  }

  @override
  void dispose() {
    _newPasswordTEController.dispose();
    _confirmNewPasswordTEController.dispose();
    super.dispose();
  }
}
