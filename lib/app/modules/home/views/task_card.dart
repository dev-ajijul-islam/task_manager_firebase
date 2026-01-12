import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_firebase/app/modules/home/data/models/task_model.dart';
import 'package:task_manager_firebase/app/modules/home/views/task_details_dialog.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        taskDetailsDialog(context: context,task: task);
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(task.title, style: TextTheme.of(context).titleMedium),
                  Chip(
                    label: Text(
                      task.priority,
                      style: .new(
                        fontWeight: .bold,
                        color: ColorScheme.of(context).primary,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: .circular(50),
                      side: BorderSide(
                        width: 0,
                        strokeAlign: 0,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
              Text(task.description),
              Row(
                spacing: 10,
                children: List.generate(
                  task.tags.length,
                  (index) => Text(
                    task.tags[index],
                    style: TextTheme.of(context).titleMedium,
                  ),
                ),
              ),
              Divider(color: Colors.grey.shade300),
              Row(
                mainAxisAlignment: task.status == "Completed"
                    ? .center
                    : .spaceBetween,
                children: [
                  Row(
                    spacing: 5,
                    children: [
                      Icon(
                        color: task.status == "Completed"
                            ? Colors.green
                            : Colors.grey,
                        task.status == "Completed"
                            ? Icons.check_circle_rounded
                            : Icons.history_toggle_off_outlined,
                        size: 20,
                      ),
                      Text(task.status),
                    ],
                  ),
                  if (task.status != "Completed") ...[
                    Text(
                      "Due Date : ${DateFormat("d MMM hh:mm a").format(task.dueDate)}",
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
