import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_firebase/app/modules/calender/controllers/calender_controller.dart';
import 'package:task_manager_firebase/app/modules/home/views/task_details_dialog.dart';

class CalenderScreen extends StatelessWidget {
  CalenderScreen({super.key});

  final CalenderController controller = Get.put(CalenderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            _monthSelector(),
            const SizedBox(height: 25),
            Expanded(child: _calendar(context)),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => Text(
              DateFormat.yMMMM().format(controller.focusedDay.value),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const Icon(Icons.search_outlined),
        ],
      ),
    );
  }

  Widget _monthSelector() {
    return SizedBox(
      height: 40,
      child: Obx(
        () => ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          scrollDirection: Axis.horizontal,
          itemCount: controller.months.length,
          separatorBuilder: (_, _) => const SizedBox(width: 10),
          itemBuilder: (_, index) {
            final isSelected = controller.focusedDay.value.month == index + 1;

            return GestureDetector(
              onTap: () => controller.changeMonth(index + 1),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.blue.shade100
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Text(
                  controller.months[index],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _calendar(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: controller.focusedDay.value,
          headerVisible: false,
          rowHeight: 80,
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (c, day, _) => _dayCell(context, day),
            todayBuilder: (c, day, _) => _dayCell(context, day, isToday: true),
            outsideBuilder: (c, day, _) =>
                _dayCell(context, day, isOutside: true),
          ),
          onPageChanged: controller.onPageChanged,
        ),
      ),
    );
  }

  Widget _dayCell(
    BuildContext context,
    DateTime day, {
    bool isToday = false,
    bool isOutside = false,
  }) {
    final taskList = controller.taskForDay(day);

    return GestureDetector(
      onTap: taskList.isEmpty
          ? null
          : () => taskDetailsDialog(context: context, task: taskList.first),
      child: Stack(
        children: [
          if (isToday)
            Container(
              clipBehavior: .none,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(3),
            child: Column(
              spacing: 2,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: .center,
              children: [
                Text(
                  "${day.day}",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isOutside ? Colors.grey : Colors.black,
                  ),
                ),
                if (taskList.isNotEmpty) ...[
                  Text(
                    taskList.first.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 10),
                  ),

                  _priorityChip(taskList.first.priority),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _priorityChip(String priority) {
    Color bg;
    Color text;

    switch (priority) {
      case "High":
        bg = const Color(0xffFFF3D6);
        text = const Color(0xffE6A100);
        break;
      case "Medium":
        bg = const Color(0xffE6F0FF);
        text = const Color(0xff2F6BFF);
        break;
      default:
        bg = const Color(0xffE8FFF1);
        text = const Color(0xff2ECC71);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        priority,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
    );
  }
}
