import 'package:flutter/material.dart';

import '../../widgets/task_card.dart';

class CanceledScreen extends StatefulWidget {
  const CanceledScreen({super.key});

  @override
  State<CanceledScreen> createState() => _CanceledScreenState();
}

class _CanceledScreenState extends State<CanceledScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: ListView.separated(
        separatorBuilder: (context,index)=>SizedBox(height: 8,),
    itemCount: 6,
    itemBuilder: (context,index){
    return TaskCard(taskStatus: TaskStatus.cancelled
    );
    },

    ),
    );
  }
}
