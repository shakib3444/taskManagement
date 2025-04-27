import 'package:flutter/material.dart';
import 'package:taskmanagement/data/service/network_client_dart.dart';
import 'package:taskmanagement/data/utils/urls.dart';
import 'package:taskmanagement/view/widgets/bg_image.dart';
import 'package:taskmanagement/view/widgets/snack_bar_message.dart';
import 'package:taskmanagement/view/widgets/tm_appbar_widget.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewTaskInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
          child: Padding(
              padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("Add New Task",style: Theme.of(context).textTheme.titleLarge,),

                  SizedBox(height: 24,),
                  TextFormField(
                    controller: _titleTEController,
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
                    controller: _descriptionTEController,
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

                  Visibility(
                    visible: _addNewTaskInProgress == false,
                    replacement: Center(child: CircularProgressIndicator(),),
                    child: ElevatedButton(
                      onPressed: ()async{
                        if(_formKey.currentState!.validate()){
                          _addNewTask();
                        }
                      },
                      child: const Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),

                ],
              ),
            ),
          )),
    );
  }

  Future<void> _addNewTask()async{
    _addNewTaskInProgress = true;
    setState(() {});
    Map<String,dynamic> requestBody={
      "title":_titleTEController.text.trim(),
      "description":_descriptionTEController.text.trim(),
      "status":"New",
    };
    final NetworkResponse response = await NetworkClient.postRequest(
        url: Urls.createTaskUrl,
    body: requestBody
    );
    _addNewTaskInProgress = false;
    setState(() {});
    if(response.isSuccess){
      showSnackBarMessage(context, "New Task added");
      _clearTextFields();

    }else{
      showSnackBarMessage(context, response.errorMessage);
    }

  }
  void _clearTextFields(){
    _titleTEController.clear();
    _descriptionTEController.clear();
  }
  @override
  void dispose() {
    super.dispose();
    _titleTEController.dispose();
    _descriptionTEController.dispose();
  }
}
