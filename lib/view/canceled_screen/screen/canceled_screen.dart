import 'package:flutter/material.dart';
import 'package:taskmanagement/data/model/task_list_model.dart';
import 'package:taskmanagement/data/model/task_model.dart';
import 'package:taskmanagement/data/service/network_client_dart.dart';
import 'package:taskmanagement/data/utils/urls.dart';
import 'package:taskmanagement/view/widgets/snack_bar_message.dart';
import '../../widgets/task_card.dart';

class CanceledScreen extends StatefulWidget {
  const CanceledScreen({super.key});

  @override
  State<CanceledScreen> createState() => _CanceledScreenState();
}

class _CanceledScreenState extends State<CanceledScreen> {
  bool isCanceledTask = false;
  List<TaskModel> taskList = [];
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
         child: Visibility(
           visible: isCanceledTask == false,
           replacement:  Center(child: CircularProgressIndicator(),),
           child: ListView.builder(
             itemCount:taskList.length,
              itemBuilder: (context,index){
            return TaskCard(
              taskStatus: TaskStatus.cancelled,
              taskModel: taskList[index],
              refreshList:getCanceledTask,
            );

               },

               ),
         ),
       ),
    );
  }

  Future<void> getCanceledTask()async{
    isCanceledTask=true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.cancelledTaskListUrl);
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ??{});
      taskList = taskListModel.taskList;
    }else{
      showSnackBarMessage(context, response.errorMessage,true);
    }
    isCanceledTask = false;
    setState(() {});
  }
}
