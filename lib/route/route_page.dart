import 'package:get/get.dart';
import 'package:taskmanagement/route/route_name.dart';
import 'package:taskmanagement/view/add_new_task/add_new_task.dart';
import 'package:taskmanagement/view/app_bottom_navigation/screen/app_bottom_navigationbar.dart';
import 'package:taskmanagement/view/auth/forgot_password_verify_email_screen.dart';
import 'package:taskmanagement/view/auth/login_screen.dart';
import 'package:taskmanagement/view/auth/otp_screen.dart';
import 'package:taskmanagement/view/auth/reset_password_screen.dart';
import 'package:taskmanagement/view/auth/sign_up_screen.dart';
import 'package:taskmanagement/view/splash_screen/screen/splash_screen.dart';
import 'package:taskmanagement/view/update_user_profile/update_user_profile.dart';

class RoutePage{
  static List<GetPage<dynamic>> route =[
    GetPage(
        name: AppRoute.splashScreen,
        page: ()=>SplashScreen(),
    ),

    GetPage(
      name: AppRoute.loginScreen,
      page: ()=>LoginScreen(),
    ),

    GetPage(
      name: AppRoute.signupScreen,
      page: ()=>SignUpScreen(),
    ),

    GetPage(
      name: AppRoute.verifyEmailScreen,
      page: ()=>ForgotPasswordVerifyEmailScreen(),
    ),
    GetPage(
      name: AppRoute.verifyOtpScreen,
      page: ()=>OtpScreen(),
    ),
    GetPage(
      name: AppRoute.resetPasswordScreen,
      page: ()=>ResetPasswordScreen(),
    ),

    GetPage(
      name: AppRoute.appBottomNavScreen,
      page: ()=>AppBottomNavigationBar(),
    ),

    GetPage(
      name: AppRoute.updateUserProfile,
      page: ()=>UpdateUserProfile(),
    ),

    GetPage(
      name: AppRoute.addNewTask,
      page: ()=>AddNewTask(),
    ),
  ];
}