import 'package:flutter/material.dart';
import 'package:taskmanagement/data/model/task_list_model.dart';
import 'package:taskmanagement/data/model/task_model.dart';
import 'package:taskmanagement/data/service/network_client_dart.dart';
import 'package:taskmanagement/data/utils/urls.dart';
import 'package:taskmanagement/view/widgets/snack_bar_message.dart';
import 'package:taskmanagement/view/widgets/task_card.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  bool _isProgressTask = false;
  List<TaskModel> taskList = [];
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
        child: Visibility(
          visible: _isProgressTask ==false,
          replacement: Center(child: CircularProgressIndicator(),),
          child: ListView.builder(
            itemCount: taskList.length,
              itemBuilder: (context,index){
                return TaskCard(
                  taskStatus: TaskStatus.progress,
                  taskModel: taskList[index],
                  refreshList:showProgressList,
                );
              },

          ),
        ),
      ),
    );
  }

  Future<void> showProgressList()async{
    _isProgressTask = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.progressTaskListUrl);
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.data??{});
      taskList = taskListModel.taskList;
    }else{
      showSnackBarMessage(context, response.errorMessage,true);
    }
    _isProgressTask =false;
    setState(() {

    });

  }
}
