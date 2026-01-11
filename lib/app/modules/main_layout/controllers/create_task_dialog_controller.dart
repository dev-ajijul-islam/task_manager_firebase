import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateTaskDialogController extends GetxController {
  var selectedDueDate = Rxn<DateTime>();
  var selectedEndDate = Rxn<DateTime>();
  var selectedPriority = "Medium".obs;
  var selectedStatus = "In Process".obs;
  var selectedFrequency = "Weekly".obs;
  var isRecurring = true.obs;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();
  final endDateController = TextEditingController();
  final tagsController = TextEditingController();



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