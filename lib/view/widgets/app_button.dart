import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key,
    required this.name,
    required this.onTap,
    this.height= 45,
    this.width=double.infinity,
    this.bgColor = Colors.green,
    this.isLoading = false,
  });
  final String name;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final Color? bgColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: bgColor,
        ),
        child: Center(
            child:isLoading?CircularProgressIndicator.adaptive(backgroundColor: Colors.white,)
                :Text(name,style:TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white),
            ),
        ),
      ),
    );
  }
}
