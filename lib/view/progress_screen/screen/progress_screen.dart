import 'package:flutter/material.dart';
import 'package:taskmanagement/view/widgets/task_card.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (context,index)=>SizedBox(height: 8,),
        itemCount: 6,
          itemBuilder: (context,index){
            return TaskCard(taskStatus: TaskStatus.progress);
          },

      ),
    );
  }
}
