import 'package:get/get.dart';
import 'package:taskmanagement/view/add_new_task/controller/add_new_task_controller.dart';
import '../../view/new_screen/controller/get_all_task_status_controller.dart';
import '../../view/new_screen/controller/new_task_controller.dart';
import '../controller/user_authentication_controller.dart';
import '../controller/user_forgot_password_controller.dart';

class ControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(UserAuthenticationController());
    Get.put(NewTaskController());
    Get.put(GetAllTaskStatusController());
    Get.lazyPut(()=>UserForgotPasswordController());
    Get.lazyPut(()=>AddNewTaskController());
  }

}