import 'package:flutter/material.dart';
import 'package:taskmanagement/route/route_name.dart';
import 'package:taskmanagement/view/new_screen/controller/new_task_controller.dart';
import 'package:taskmanagement/view/widgets/snack_bar_message.dart';
import 'package:taskmanagement/view/widgets/task_card.dart';
import '../controller/get_all_task_status_controller.dart';
import '../widget/summary_card.dart';
import 'package:get/get.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final NewTaskController newTaskController = Get.find();
  final GetAllTaskStatusController taskStatusController = Get.find();


  @override
  void initState() {
    super.initState();
    _getAllTaskStatusCount();
    _getAllNewTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            //status
            GetBuilder<GetAllTaskStatusController>(
              builder: (controller) {
                return Visibility(
                  visible: controller.getStatusCountInProgress == false,
                  replacement: const Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                  child: _buildSummarySection(),
                );
              }
            ),


            GetBuilder<NewTaskController>(
              builder: (controller) {
                return Visibility(
                  visible: controller.isGetAllTask == false,
                  replacement: const SizedBox(
                    height: 300,
                    child: CircularProgressIndicator(),
                  ),
                  child: ListView.separated(
                    itemCount: newTaskController.newTaskList!.length,
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskStatus: TaskStatus.sNew,
                        taskModel: controller.newTaskList![index],
                        refreshList: _getAllNewTaskList,
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                  ),
                );
              }
            )

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed:_onTapAddNewTask,
        child: Icon(Icons.add),
      ),
    );
  }
  void _onTapAddNewTask(){
    Get.toNamed(AppRoute.addNewTask);
  }

  Widget _buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:taskStatusController.taskStatusCountList!.length,
          itemBuilder: (context, index) {
            final data = taskStatusController.taskStatusCountList![index];
            return SummaryCard(
                title: data.status,
                count: data.count
            );
          },
        ),
      ),
    );
  }

  Future<void > _getAllTaskStatusCount()async{
    bool isSuccess =await taskStatusController.getAllTaskStatusCount();
    if(isSuccess){
      showSnackBarMessage(context, "Get Task Status Success");
    }

  }



  Future<void> _getAllNewTaskList()async{
    bool isSuccess = await newTaskController.getAllNewTaskList();
   if(isSuccess){
      showSnackBarMessage(context, "Get New Task Success");
    }
  }

}


