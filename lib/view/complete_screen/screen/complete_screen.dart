import 'package:flutter/material.dart';

import '../../widgets/task_card.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({super.key});

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (context,index)=>SizedBox(height: 8,),
        itemCount: 6,
        itemBuilder: (context,index){
          return TaskCard(taskStatus: TaskStatus.completed);
        },

      ),
    );
  }
}
