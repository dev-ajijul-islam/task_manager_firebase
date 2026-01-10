import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_firebase/app/modules/calender/controllers/calender_controller.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  final CalenderController calenderController = Get.put(CalenderController());

  @override
  Widget build(BuildContext context) {
    var focusedDay = calenderController.focusedDay;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Row(children: [
                    IconButton(
                      icon: const Icon(Icons.calendar_month_outlined),
                      onPressed: () {},
                    ),
                    Obx(
                          () => Text(
                        DateFormat.yMMMM().format(focusedDay.value),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],),
                  IconButton(onPressed: () {
                    
                  }, icon: Icon(Icons.search_outlined))
                ],
              ),
            ),

            SizedBox(
              height: 40,
              child: Obx(() {
                final focusedDay = calenderController.focusedDay.value;

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: calenderController.months.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final isSelected = focusedDay.month == index + 1;

                    return GestureDetector(
                      onTap: () {
                        calenderController.changeMonth(index + 1);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blue.shade100
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            calenderController.months[index],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            const SizedBox(height: 12),

            Obx(
              () => Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TableCalendar(
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: focusedDay.value,

                      headerVisible: false,
                      rowHeight: 88,

                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, _) => _buildDayCell(day),
                        todayBuilder: (context, day, _) =>
                            _buildDayCell(day, isToday: true),
                        outsideBuilder: (context, day, _) =>
                            _buildDayCell(day, isOutside: true),
                      ),

                      onPageChanged: (day) {
                        focusedDay(day);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, String>? _taskForDay(DateTime day) {
    final tasks = {
      "2025-5-2": {"title": "Bug fixing", "priority": "High"},
      "2025-5-6": {"title": "Update UI", "priority": "Low"},
      "2025-5-8": {"title": "Design task", "priority": "High"},
      "2025-5-12": {"title": "Implement flow", "priority": "Medium"},
      "2025-5-15": {"title": "Update logic", "priority": "Low"},
      "2025-5-19": {"title": "Design task", "priority": "High"},
      "2025-5-23": {"title": "Update API", "priority": "Low"},
      "2025-5-30": {"title": "Implement feature", "priority": "Medium"},
    };

    return tasks["${day.year}-${day.month}-${day.day}"];
  }

  Widget _buildDayCell(
    DateTime day, {
    bool isToday = false,
    bool isOutside = false,
  }) {
    final task = _taskForDay(day);

    return Stack(
      children: [
        if (isToday)
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

        Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${day.day}",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isOutside ? Colors.grey : Colors.black,
                ),
              ),

              if (task != null) ...[
                const SizedBox(height: 6),
                Text(
                  task["title"]!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11),
                ),
                const SizedBox(height: 6),
                _priorityChip(task["priority"]!),
              ],
            ],
          ),
        ),
      ],
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

    return SizedBox(
      height: 18,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          priority,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: text,
          ),
        ),
      ),
    );
  }
}
