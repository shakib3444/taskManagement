import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskmanagement/utilis/assets_path.dart';
import 'package:taskmanagement/view/auth/login_screen.dart';
import 'package:taskmanagement/view/widgets/bg_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }
  void _moveToNextScreen()async{
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ScreenBackground(
          child:Center(child: SvgPicture.asset(AssetsPath.logoSvg,width: 120,),)),
    );
  }
}
