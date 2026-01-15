import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_firebase/app/modules/home/controllers/categories_controller.dart';
import 'package:task_manager_firebase/app/modules/home/data/models/task_model.dart';

class CreateTaskDialogController extends GetxController {

  final bool? isUpdate;
  final TaskModel? task;
  var selectedDueDate = Rxn<DateTime>();
  var selectedEndDate = Rxn<DateTime>();
  var selectedPriority = "Medium".obs;
  var selectedStatus = "In Process".obs;
  var selectedFrequency = "Weekly".obs;
  var isRecurring = false.obs;
  RxList<String> tags = <String>[].obs;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();
  final endDateController = TextEditingController();
  final tagsController = TextEditingController();

  CreateTaskDialogController({this.isUpdate, this.task});

  void removeTag(int index){
    tags.removeAt(index);
  }

  void selectDate(BuildContext context, bool isDueDate) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      if (isDueDate) {
        selectedDueDate.value = date;
        dueDateController.text = DateFormat('MMM d, yyyy').format(date);
      } else {
        selectedEndDate.value = date;
        endDateController.text = DateFormat('dd-MM-yyyy').format(date);
      }
    }
  }


  void clearFields(){
    titleController.clear();
    descriptionController.clear();
    dueDateController.clear();
    endDateController.clear();
    tagsController.clear();
    tags.clear();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    dueDateController.dispose();
    endDateController.dispose();
    tagsController.dispose();
    super.onClose();
  }
}
