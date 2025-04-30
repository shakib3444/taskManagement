import 'package:get/get.dart';
import '../../../data/model/task_list_model.dart';
import '../../../data/model/task_model.dart';
import '../../../data/model/task_status_count_model.dart';
import '../../../data/service/network_client_dart.dart';
import '../../../data/utils/urls.dart';

class NewTaskController extends GetxController{

  bool _isGetAllTask = false;
  String? _errorMessage;
  final List<TaskStatusCountModel> _taskStatusCountList = [];
  List<TaskModel> _newTaskList = [];

  bool? get isGetAllTask => _isGetAllTask;
  List? get newTaskList => _newTaskList;
  List? get taskStatusCountList => _taskStatusCountList;




  //get all task
  Future<bool> getAllNewTaskList()async{
    bool isSuccess = false;

    _isGetAllTask = true;
    update();
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.newTaskListUrl);
    if(response.isSuccess){
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _newTaskList = taskListModel.taskList;
      isSuccess = true;
      _errorMessage = null;
    }else{
      _errorMessage = response.errorMessage;
    }
    _isGetAllTask  = false;
    update();
    return isSuccess;
  }
}