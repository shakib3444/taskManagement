import 'package:flutter/material.dart';
import 'package:taskmanagement/data/model/task_list_model.dart';
import 'package:taskmanagement/data/service/network_client_dart.dart';
import 'package:taskmanagement/data/utils/urls.dart';
import 'package:taskmanagement/view/add_new_task/add_new_task.dart';
import 'package:taskmanagement/view/widgets/snack_bar_message.dart';
import 'package:taskmanagement/view/widgets/task_card.dart';
import '../../../data/model/task_model.dart';
import '../../../data/model/task_status_count_list_model.dart';
import '../../../data/model/task_status_count_model.dart';
import '../widget/summary_card.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  bool _getStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];
  bool _getNewTasksInProgress = false;
  List<TaskModel> _newTaskList = [];

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
            Visibility(
              visible: _getStatusCountInProgress == false,
              replacement: const Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
              child: _buildSummarySection(),
            ),
            Visibility(
              visible: _getNewTasksInProgress == false,
              replacement: const SizedBox(
                height: 300,
                child: CircularProgressIndicator(),
              ),
              child: ListView.separated(
                itemCount: _newTaskList.length,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskStatus: TaskStatus.sNew,
                    taskModel: _newTaskList[index],
                    refreshList: _getAllNewTaskList,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 8),
              ),
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
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewTask()));
  }

  Widget _buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _taskStatusCountList.length,
          itemBuilder: (context, index) {
            return SummaryCard(
                title: _taskStatusCountList[index].status,
                count: _taskStatusCountList[index].count
            );
          },
        ),
      ),
    );
  }

  Future<void > _getAllTaskStatusCount()async{
    _getStatusCountInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.taskStatusCountUrl);
    if(response.isSuccess){
      TaskStatusCountListModel taskStatusCountListModel = TaskStatusCountListModel.fromJson(response.data ?? {});
      _taskStatusCountList = taskStatusCountListModel.statusCountList;
    }else{
      showSnackBarMessage(context, response.errorMessage,true);
    }
    _getStatusCountInProgress = false;
    setState(() {});
  }



  Future<void> _getAllNewTaskList()async{
    _getNewTasksInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.newTaskListUrl);
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _newTaskList = taskListModel.taskList;
    }else{
      showSnackBarMessage(context, response.errorMessage,true);
    }
    _getNewTasksInProgress = false;
    setState(() {

    });
  }

}


