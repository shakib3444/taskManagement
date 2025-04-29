import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanagement/view/add_new_task/controller/add_new_task_controller.dart';
import 'package:taskmanagement/view/widgets/bg_image.dart';
import 'package:taskmanagement/view/widgets/tm_appbar_widget.dart';

class AddNewTask extends GetView<AddNewTaskController> {
  const AddNewTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key:controller.formKey.value,
              child: Column(
                children: [
                  Text("Add New Task",style: Theme.of(context).textTheme.titleLarge,),

                  SizedBox(height: 24,),
                  TextFormField(
                    controller:controller.titleTEController.value,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        hintText: 'Title'
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    maxLines: 6,
                    controller:controller.descriptionTEController.value,
                    decoration: const InputDecoration(
                        hintText: 'Description',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your Description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16,),

                  Obx((){
                      return Visibility(
                        visible: controller.addNewTaskInProgress.value == false,
                        replacement: Center(child: CircularProgressIndicator(),),
                        child: ElevatedButton(
                          onPressed: ()async{
                            if(controller.formKey.value.currentState!.validate()){
                              controller.addNewTask();
                            }
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      );
                    }
                  ),

                ],
              ),
            ),
          )),
    );
  }
}

