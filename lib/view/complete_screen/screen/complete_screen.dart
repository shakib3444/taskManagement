import 'package:flutter/material.dart';
import 'package:taskmanagement/data/model/task_list_model.dart';
import 'package:taskmanagement/data/model/task_model.dart';
import 'package:taskmanagement/data/service/network_client_dart.dart';
import 'package:taskmanagement/data/utils/urls.dart';

import '../../widgets/snack_bar_message.dart';
import '../../widgets/task_card.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({super.key});

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  bool isCompleteTask = false;
  List<TaskModel> taskList =[];
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
        child: Visibility(
          visible: isCompleteTask == false,
          replacement: Center(child: CircularProgressIndicator(),),
          child: ListView.separated(
            separatorBuilder: (context,index)=>SizedBox(height: 8,),
            itemCount: taskList.length,
            itemBuilder: (context,index){
              return TaskCard(
                taskStatus: TaskStatus.completed,
                taskModel: taskList[index],
                refreshList:getCompleteTask,
              );
            },

          ),
        ),
      ),
    );
  }

  Future<void> getCompleteTask ()async{
    isCompleteTask = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.completedTaskListUrl);
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.data??{});
      taskList = taskListModel.taskList;
    }else{
      showSnackBarMessage(context, response.errorMessage,true);
    }
    isCompleteTask = false;
    setState(() {});

  }
}
