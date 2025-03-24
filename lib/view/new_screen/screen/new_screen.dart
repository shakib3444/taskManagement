import 'package:flutter/material.dart';
import 'package:taskmanagement/view/widgets/task_card.dart';

import '../widget/summary_card.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildSummarySection(),
            ListView.separated(
              itemCount: 6,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context,index){
              return TaskCard(taskStatus: TaskStatus.sNew);
            },
              separatorBuilder: (context,index)=>SizedBox(height: 8,),
            )


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){},
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildSummarySection() {
    return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SummaryCard(count: 12,title: "New",),
              SummaryCard(count: 23,title: "Progress",),
              SummaryCard(count: 3,title: "Completed",),
              SummaryCard(count: 24,title: "Cancelled",),
            ],
          ),
        );
  }

}


