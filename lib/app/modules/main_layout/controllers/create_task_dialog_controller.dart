import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateTaskDialogController extends GetxController {
  var selectedDueDate = Rxn<DateTime>();
  var selectedEndDate = Rxn<DateTime>();
  var selectedPriority = "Medium".obs;
  var selectedStatus = "In Process".obs;
  var selectedFrequency = "Weekly".obs;
  var isRecurring = true.obs;

  Future<void> selectDate(BuildContext context, bool isDueDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      if (isDueDate) {
        selectedDueDate.value = picked;
      } else {
        selectedEndDate.value = picked;
      }
    }
  }
}