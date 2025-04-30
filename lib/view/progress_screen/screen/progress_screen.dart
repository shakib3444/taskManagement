import 'package:flutter/material.dart';
import 'package:taskmanagement/view/widgets/snack_bar_message.dart';
import 'package:taskmanagement/view/widgets/task_card.dart';
import 'package:get/get.dart';
import '../controller/progress_controller.dart';


class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  final ProgressController progressController = Get.find();

  @override
  void initState() {
    super.initState();
    showProgressList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<ProgressController>(
          builder: (controller) {
            return Visibility(
              visible: controller.isProgressTask ==false,
              replacement: Center(child: CircularProgressIndicator(),),
              child: ListView.builder(
                itemCount:progressController.taskList.length,
                  itemBuilder: (context,index){
                    return TaskCard(
                      taskStatus: TaskStatus.progress,
                      taskModel:progressController.taskList[index],
                      refreshList:showProgressList,
                    );
                  },

              ),
            );
          }
        ),
      ),
    );
  }

  Future<void> showProgressList()async{
    bool isSuccess =await progressController.showProgressList();
    if(isSuccess){
      showSnackBarMessage(context, "Progress Task get Success");
    }

  }
}
