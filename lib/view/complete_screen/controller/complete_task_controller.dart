import 'package:get/get.dart';
import '../../../data/model/task_list_model.dart';
import '../../../data/model/task_model.dart';
import '../../../data/service/network_client_dart.dart';
import '../../../data/utils/urls.dart';

class CompleteTaskController extends GetxController{
  bool isCompleteTask = false;
  String? errorMessage;
  List<TaskModel> taskList =[];



  Future<bool> getCompleteTask ()async{
    bool isSuccess = false;

    isCompleteTask = true;
    update();
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.completedTaskListUrl);
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.data??{});
      taskList = taskListModel.taskList;
      errorMessage = null;
      isSuccess = true;
    }else{
      errorMessage = response.errorMessage;
    }

    isCompleteTask = false;
    update();
    return isSuccess;

  }
}