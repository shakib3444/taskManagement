import 'package:get/get.dart';

import '../../../data/model/task_status_count_list_model.dart';
import '../../../data/model/task_status_count_model.dart';
import '../../../data/service/network_client_dart.dart';
import '../../../data/utils/urls.dart';

class GetAllTaskStatusController extends GetxController{
  bool _getStatusCountInProgress= false;
  String? _errorMessage ;
   List<TaskStatusCountModel> _taskStatusCountList = [];
  List? get taskStatusCountList => _taskStatusCountList;
  bool? get getStatusCountInProgress => _getStatusCountInProgress;

  @override
  void onInit() {
    super.onInit();
    getAllTaskStatusCount();
  }

  Future<bool> getAllTaskStatusCount()async{
    bool isSuccess = false;

    _getStatusCountInProgress = true;
    update();
    final NetworkResponse response = await NetworkClient.getRequest(url: Urls.taskStatusCountUrl);
    if(response.isSuccess){
      TaskStatusCountListModel taskStatusCountListModel = TaskStatusCountListModel.fromJson(response.data ?? {});
      _taskStatusCountList = taskStatusCountListModel.statusCountList;
      isSuccess = true;
      _errorMessage = null;
    }else{
      _errorMessage = response.errorMessage;
    }
    _getStatusCountInProgress = false;
    update();

    return isSuccess;
  }

}