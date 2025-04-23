
import 'package:taskmanagement/data/model/task_model.dart';

class TaskListModel{
  late final  String static;
  late final List<TaskModel> taskList;

  TaskListModel.fromJson(Map<String,dynamic> json){
    static = json['status'];
    if(json['data'] != null){
      List<TaskModel> list =[];
      for(Map<String,dynamic>data in json['data']){
        list.add(TaskModel.fromJson(data));
      }
      taskList = list;
    }else{
      taskList =[];
    }
  }
}