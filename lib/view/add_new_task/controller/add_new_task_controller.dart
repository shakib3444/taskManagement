import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../data/service/network_client_dart.dart';
import '../../../data/utils/urls.dart';

class AddNewTaskController extends GetxController{
  final Rx<TextEditingController> titleTEController = TextEditingController().obs;
  final Rx<TextEditingController> descriptionTEController = TextEditingController().obs;
  final Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  final RxBool addNewTaskInProgress = false.obs;



  Future<void> addNewTask()async{
    addNewTaskInProgress.value = true;
    Map<String,dynamic> requestBody={
      "title":titleTEController.value.text.trim(),
      "description":descriptionTEController.value.text.trim(),
      "status":"New",
    };
    final NetworkResponse response = await NetworkClient.postRequest(
        url: Urls.createTaskUrl,
        body: requestBody
    );
    if(response.isSuccess){
      allClear();
      Get.snackbar("Success", "Add New Task Success",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

    }else{
      Get.snackbar("Failed", response.errorMessage,backgroundColor: Colors.red,colorText: Colors.black,snackPosition: SnackPosition.BOTTOM);

    }
    addNewTaskInProgress.value = false;

  }

  allClear(){
    titleTEController.value.clear();
    descriptionTEController.value.clear();
  }
}