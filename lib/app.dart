import 'package:flutter/material.dart';
import 'package:taskmanagement/view/splash_screen/screen/splash_screen.dart';

class TaskManage extends StatefulWidget {
  const TaskManage({super.key});

  @override
  State<TaskManage> createState() => _TaskManageState();
}

class _TaskManageState extends State<TaskManage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey),
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          border: _getZeroBorder(),
          enabledBorder: _getZeroBorder(),
          errorBorder: _getZeroBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromWidth(double.maxFinite),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )
          )
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),
        )
      ),


    );
  }

  OutlineInputBorder _getZeroBorder(){
    return OutlineInputBorder(
      borderSide: BorderSide.none,
    );

  }
}
