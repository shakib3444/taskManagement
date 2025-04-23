import 'package:flutter/material.dart';
import 'package:taskmanagement/utilis/app_color.dart';

class SummeryCard extends StatelessWidget {
  const SummeryCard({super.key, required this.title, required this.count});
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.textWhite,
      child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24,vertical: 16,
          ),
        child: Column(
          children: [
            Text("$count",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
            Text(title),
          ],
        ),
      ),
    );
  }
}
