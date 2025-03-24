import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key, required this.count, required this.title,
  });
  final int count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 16),
        child: Column(
          children: [
            Text("$count",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
            Text(title)

          ],
        ),
      ),
    );
  }
}