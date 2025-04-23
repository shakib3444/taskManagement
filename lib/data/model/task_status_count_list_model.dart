

import 'package:taskmanagement/data/model/task_status_count_model.dart';

class TaskStatusCountListModel{
  late final String static;
  late final List<TaskStatusCountModel> statusCountList;

  TaskStatusCountListModel.fromJson(Map<String,dynamic>json){
    static = json['status'];
    if(json['data'] != null){
      List<TaskStatusCountModel> list =[];
      for(Map<String, dynamic>data in json['data']){
        list.add(TaskStatusCountModel.fromJson(data));
      }
      statusCountList = list;
    }else{
      statusCountList =[];
    }
  }
}