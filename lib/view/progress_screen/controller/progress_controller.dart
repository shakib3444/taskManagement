import 'package:get/get.dart';

import '../../../data/model/task_list_model.dart';
import '../../../data/model/task_model.dart';
import '../../../data/service/network_client_dart.dart';
import '../../../data/utils/urls.dart';

class ProgressController extends GetxController{

  bool _isProgressTask = false;
  String? _errorMessage;
  List<TaskModel> taskList = [];

  bool? get isProgressTask => _isProgressTask;


  Future<bool> showProgressList()async{
    bool isSuccess = false;

    _isProgressTask = true;
    update();
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.progressTaskListUrl);
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.data??{});
      taskList = taskListModel.taskList;
      isSuccess = true;
      _errorMessage = null;
    }else{
      _errorMessage = response.errorMessage;
    }
    _isProgressTask =false;
    update();
    return isSuccess;
  }
}