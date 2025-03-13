import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskmanagement/utilis/assets_path.dart';

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
            AssetsPath.bgImage,
          height: double.maxFinite,
          width: double.maxFinite,
          fit:BoxFit.cover,
        ),
        SafeArea(child: child)

      ],
    );
  }
}
