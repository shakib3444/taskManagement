import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanagement/route/route_name.dart';
import 'package:taskmanagement/route/route_page.dart';

import 'data/binding/controller_binding.dart';

class TaskManage extends StatefulWidget {
  const TaskManage({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManage> createState() => _TaskManageState();
}

class _TaskManageState extends State<TaskManage> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManage.navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.splashScreen,
      getPages: RoutePage.route,
      initialBinding: ControllerBinding(),

      //home: SplashScreen(),
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
