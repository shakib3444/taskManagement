import 'package:get/get.dart';

import '../../../data/model/task_list_model.dart';
import '../../../data/model/task_model.dart';
import '../../../data/service/network_client_dart.dart';
import '../../../data/utils/urls.dart';


class CanceledTaskController extends GetxController{
  bool isCanceledTask = false;
  String? errorMessage;
  List<TaskModel> taskList = [];



  Future<bool> getAllCanceledTask()async{
    bool isSuccess = false;

    isCanceledTask=true;
    update();
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.cancelledTaskListUrl);
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ??{});
      taskList = taskListModel.taskList;
      isSuccess = true;
      errorMessage =null;
    }else{
      errorMessage = response.errorMessage;
    }
    isCanceledTask = false;
    update();

    return isSuccess;
  }
}