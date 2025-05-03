import 'package:get/get.dart';

import '../service/network_client_dart.dart';
import '../utils/urls.dart';

class EditTaskController extends GetxController{

  bool _changeStatusProgress = false;
  String? errorMessage ;


   changeStatus(String id,String status)async{
    bool isSuccess = false;
    _changeStatusProgress = true;
   update();
    NetworkResponse response = await NetworkClient.getRequest(url: Urls.updateTaskStatusUrl(id,status));
    if(response.isSuccess){
      isSuccess = true;
      errorMessage = null;
    }else{
      errorMessage = response.errorMessage;
    }
    _changeStatusProgress = false;
    update();

  }

  // Future<void> deleteTask()async{
  //   _inProgress = true;
  //   setState(() {
  //   });
  //   final NetworkResponse response = await NetworkClient.getRequest(url: Urls.deleteTaskUrl(widget.taskModel.id));
  //   _inProgress= false;
  //   if(response.isSuccess){
  //     widget.refreshList();
  //   }else{
  //     setState(() {
  //
  //     });
  //     showSnackBarMessage(context, response.errorMessage,true);
  //   }
  //
  // }
}