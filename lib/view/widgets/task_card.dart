import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskmanagement/data/controller/edit_task_controller.dart';
import 'package:taskmanagement/data/service/network_client_dart.dart';
import 'package:taskmanagement/data/utils/urls.dart';
import 'package:taskmanagement/view/widgets/snack_bar_message.dart';
import 'package:get/get.dart';
import '../../data/model/task_model.dart';

enum TaskStatus{
  sNew,
  progress,
  completed,
  cancelled
}

class TaskCard extends StatelessWidget{
  TaskCard({super.key,
    required this.taskStatus,
    required this.taskModel,
    required this.refreshList,
  });
  final TaskStatus taskStatus;
  final TaskModel taskModel;
  final VoidCallback refreshList;
  final EditTaskController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(taskModel.title,style: TextStyle(fontWeight: FontWeight.w600),),
            Text(taskModel.description,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.black,
              ),
            ),
            Text("Date: ${DateFormat('yyyy-MM-dd HH:mm')
                .format(DateTime.parse(taskModel.createdDate))}",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.black,
              ),
            ),
            Row(
              children: [
                Chip(
                  label: Text(taskModel.status,
                    style: TextStyle(color: Colors.white,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor:_getStatusChipColor() ,
                  side: BorderSide.none,
                ),
                Spacer(),
                IconButton(
                    onPressed: ()=>deleteTask(),
                    icon: Icon(Icons.delete,color: Colors.red,
                    ),
                ),
                IconButton(
                    onPressed: ()=>showUpdateStatusDialog(),
                    icon: Icon(Icons.edit,color: Colors.orange,),
                ),


              ],
            )

          ],
        ),
      ),

    );
  }
  Color _getStatusChipColor(){
    late Color color;
    switch(taskStatus){
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

  bool isSelected(String status)=>taskModel.status == status;

  void showUpdateStatusDialog(){
    Get.dialog(
        AlertDialog(
          title:Text('Update Status') ,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: (){
                  Get.back();
                  if(isSelected("New")) return;
                  _changeTaskStatus("New");
                },
                title: Text("New"),
                trailing: isSelected("New")?Icon(Icons.done):null,
              ),
              ListTile(
                onTap: (){
                  Get.back();
                  if(isSelected("Progress")) return;
                  _changeTaskStatus("Progress");
                },
                title: Text("Progress"),
                trailing: isSelected("Progress")?Icon(Icons.done):null,
              ),
              ListTile(
                onTap: (){
                  Get.back();
                  if(isSelected("Completed")) return;
                  _changeTaskStatus("Completed");
                },
                title: Text("Completed"),
                trailing: isSelected("Completed")?Icon(Icons.done):null,
              ),
              ListTile(
                onTap: (){
                  Get.back();
                  if(isSelected("Cancelled")) return;
                  _changeTaskStatus("Cancelled");
                },
                title: Text("Cancelled"),
                trailing: isSelected("Cancelled")?Icon(Icons.done):null,
              ),
            ],
          ),
        ));

  }

  void _changeTaskStatus(String status)async{
    bool isSuccess = await controller.changeStatus(
        taskModel.id.toString(), status);
    if(isSuccess){
      Get.snackbar("Success", "Edit Success");
      refreshList();
    }

  }

  Future<void> deleteTask()async{
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.deleteTaskUrl(taskModel.id));
    if(response.isSuccess){
      refreshList();
      Get.snackbar("Success", "Delete Successful");
    }else{
      Get.snackbar("Failed", response.errorMessage);
    }

  }
}

// class TaskCard extends StatefulWidget {
//   const TaskCard({super.key,
//     required this.taskStatus,
//     required this.taskModel,
//     required this.refreshList,
//   });
//
//
//
//   @override
//   State<TaskCard> createState() => _TaskCardState();
// }
//
// class _TaskCardState extends State<TaskCard> {
//   final EditTaskController editTaskController = Get.find();
//   bool _inProgress = false;
//   @override
//   Widget build(BuildContext context) {
//
//     return Card(
//       elevation: 0,
//       color: Colors.white,
//       margin: EdgeInsets.symmetric(horizontal: 16),
//       child: Padding(padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(widget.taskModel.title,style:TextStyle(fontWeight: FontWeight.w600),),
//           Text(widget.taskModel.description),
//           Text(),
//           Row(
//             children: [
//               Chip(
//                 label: Text(widget.taskModel.status,style: TextStyle(color: Colors.white),),
//                 padding: EdgeInsets.symmetric(horizontal: 8),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//                 backgroundColor:_getStatusChipColor() ,
//                 side: BorderSide.none,
//               ),
//               Spacer(),
//               IconButton(onPressed: ()=>deleteTask(), icon: Icon(Icons.delete,color: Colors.red)),
//               //IconButton(onPressed: ()=>showUpdateStatusDialog(), icon: Icon(Icons.edit,color: Colors.orange,)),
//
//
//             ],
//           )
//
//         ],
//       ),),
//     );
//   }
//
//
// }