import 'package:get/get.dart';

class CalenderController extends GetxController {
  final focusedDay = DateTime(2025, 5, 1).obs;

  var months =  [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
  ].obs;

  void changeMonth(int month) {
    focusedDay.value = DateTime(focusedDay.value.year, month, 1);
  }

  void onPageChanged(DateTime day) {
    focusedDay.value = day;
  }

  Map<String, String>? taskForDay(DateTime day) {
    final tasks = {
      "2025-5-2": {"title": "Bug fixing", "priority": "High"},
      "2025-5-6": {"title": "Update UI", "priority": "Low"},
      "2025-5-8": {"title": "Design task", "priority": "High"},
      "2025-5-12": {"title": "Implement flow", "priority": "Medium"},
      "2025-5-15": {"title": "Update logic", "priority": "Low"},
    };

    return tasks["${day.year}-${day.month}-${day.day}"];
  }
}
