import 'dart:convert';

import 'package:flutter/material.dart';

import '../../data/controller/auth_controller.dart';
import '../auth/login_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget{
  const TMAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.green,
      title: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: showImage(AuthController.userModel?.photo)
                ?MemoryImage(base64Decode(AuthController.userModel!.photo??""),
            ):null,
          ),
          SizedBox(width: 16,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AuthController.userModel?.fulName??'UnKnown',style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),),
              Text(AuthController.userModel?.email ?? 'Unknown',style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade200),)
            ],
          ),
          Spacer(),
          IconButton(
              onPressed:()=>_onTapLogOutButton(context),
              icon: Icon(Icons.logout,color: Colors.white,
              ),
          ),
        ],
      ),
    );
  }


  Future<void> _onTapLogOutButton(BuildContext context) async {
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ), (predicate) => false);
  }

  bool showImage(String? photo){
    return photo != null && photo.isNotEmpty;
  }

  @override

  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}