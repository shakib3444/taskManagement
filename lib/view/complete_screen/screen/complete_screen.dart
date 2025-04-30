import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanagement/view/complete_screen/controller/complete_task_controller.dart';
import '../../widgets/snack_bar_message.dart';
import '../../widgets/task_card.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({super.key});

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  final CompleteTaskController completeTaskController = Get.find();

  @override
  void initState() {
    super.initState();
    getCompleteTask();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<CompleteTaskController>(
          builder: (controller) {
            return Visibility(
              visible: controller.isCompleteTask == false,
              replacement: Center(child: CircularProgressIndicator(),),
              child: ListView.separated(
                separatorBuilder: (context,index)=>SizedBox(height: 8,),
                itemCount: controller.taskList.length,
                itemBuilder: (context,index){
                  return TaskCard(
                    taskStatus: TaskStatus.completed,
                    taskModel: controller.taskList[index],
                    refreshList:getCompleteTask,
                  );
                },

              ),
            );
          }
        ),
      ),
    );
  }

  Future<void> getCompleteTask ()async{
    bool isSuccess =await completeTaskController.getCompleteTask();

    if(isSuccess){
      showSnackBarMessage(context, "Complete Task get success");
    }
  }
}
