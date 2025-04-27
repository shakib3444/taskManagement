import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskmanagement/data/service/network_client_dart.dart';
import 'package:taskmanagement/data/utils/urls.dart';
import 'package:taskmanagement/view/widgets/snack_bar_message.dart';

import '../../data/model/task_model.dart';

enum TaskStatus{
  sNew,
  progress,
  completed,
  cancelled
}


class TaskCard extends StatefulWidget {
  const TaskCard({super.key,
    required this.taskStatus,
    required this.taskModel,
    required this.refreshList,
  });
  final TaskStatus taskStatus;
  final TaskModel taskModel;
  final VoidCallback refreshList;


  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _inProgress = false;
  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Padding(padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.taskModel.title,style:TextStyle(fontWeight: FontWeight.w600),),
          Text(widget.taskModel.description),
          Text("Date: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(widget.taskModel.createdDate))}"),
          Row(
            children: [
              Chip(
                label: Text(widget.taskModel.status,style: TextStyle(color: Colors.white),),
                padding: EdgeInsets.symmetric(horizontal: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                backgroundColor:_getStatusChipColor() ,
                side: BorderSide.none,
              ),
              Spacer(),
              IconButton(onPressed: ()=>deleteTask(), icon: Icon(Icons.delete,color: Colors.red)),
              IconButton(onPressed: ()=>showUpdateStatusDialog(), icon: Icon(Icons.edit,color: Colors.orange,)),


            ],
          )

        ],
      ),),
    );
  }

  Color _getStatusChipColor(){
    late Color color;
    switch(widget.taskStatus){
      case TaskStatus.sNew:
        color=Colors.blue;
      case TaskStatus.progress:
        color = Colors.orange;
      case TaskStatus.completed:
        color = Colors.green;
      case TaskStatus.cancelled:
        color = Colors.red;

    }
    return color;
  }

  bool isSelected(String status)=>widget.taskModel.status == status;

  void showUpdateStatusDialog(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Update Status'),
        content: Column(
          children: [
            ListTile(
              onTap: (){
                Navigator.pop(context);
                if(isSelected("New")) return;
                _changeTaskStatus("New");
              },
              title: Text("New"),
              trailing: isSelected("New")?Icon(Icons.done):null,
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                if(isSelected("Progress")) return;
                _changeTaskStatus("Progress");
              },
              title: Text("Progress"),
              trailing: isSelected("Progress")?Icon(Icons.done):null,
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                if(isSelected("Completed")) return;
                _changeTaskStatus("Completed");
              },
              title: Text("Completed"),
              trailing: isSelected("Completed")?Icon(Icons.done):null,
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                if(isSelected("Cancelled")) return;
                _changeTaskStatus("Cancelled");
              },
              title: Text("Cancelled"),
              trailing: isSelected("Cancelled")?Icon(Icons.done):null,
            ),
          ],
        ),
      );
    });
  }

  void _changeTaskStatus(String status)async{
    _inProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkClient.getRequest(url: Urls.updateTaskStatusUrl(widget.taskModel.id,status));
    _inProgress = false;
    if(response.isSuccess){
      widget.refreshList();
    }else{
      setState(() {

      });
      showSnackBarMessage(context, response.errorMessage,true);
    }

  }

  Future<void> deleteTask()async{
    _inProgress = true;
    setState(() {
    });
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.deleteTaskUrl(widget.taskModel.id));
    _inProgress= false;
    if(response.isSuccess){
      widget.refreshList();
    }else{
      setState(() {

      });
      showSnackBarMessage(context, response.errorMessage,true);
    }

  }
}