import 'package:flutter/material.dart';
import 'package:taskmanagement/view/canceled_screen/controller/canceled_task_controller.dart';
import 'package:taskmanagement/view/widgets/snack_bar_message.dart';
import '../../widgets/task_card.dart';
import 'package:get/get.dart';

class CanceledScreen extends StatefulWidget {
  const CanceledScreen({super.key});

  @override
  State<CanceledScreen> createState() => _CanceledScreenState();
}

class _CanceledScreenState extends State<CanceledScreen> {
  final CanceledTaskController canceledTaskController = Get.find();

  @override
  void initState() {
    super.initState();
    getCanceledTask();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Padding(
         padding: EdgeInsets.all(16),
         child: GetBuilder<CanceledTaskController>(
           builder: (controller) {
             return Visibility(
               visible: controller.isCanceledTask == false,
               replacement:  Center(child: CircularProgressIndicator(),),
               child: ListView.builder(
                 itemCount:controller.taskList.length,
                  itemBuilder: (context,index){
                return TaskCard(
                  taskStatus: TaskStatus.cancelled,
                  taskModel: controller.taskList[index],
                  refreshList:getCanceledTask,
                );

                   },

                   ),
             );
           }
         ),
       ),
    );
  }

  Future<void> getCanceledTask()async{
   bool isSuccess =await canceledTaskController.getAllCanceledTask();
   if(isSuccess){
     showSnackBarMessage(context, "Get all canceled Task success");
   }
  }
}
