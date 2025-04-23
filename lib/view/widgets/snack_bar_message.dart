
import 'package:flutter/material.dart';

import '../../utilis/app_color.dart';

void showSnackBarMessage(BuildContext context,String message,[bool isError = false]){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError?AppColors.textRed:null,
          content: Text(message,style: TextStyle(color: AppColors.textWhite),
          ),
      ),
  );
}