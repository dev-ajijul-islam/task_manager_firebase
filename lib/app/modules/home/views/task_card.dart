import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_firebase/app/modules/home/data/models/task_model.dart';
import 'package:task_manager_firebase/app/modules/home/views/task_details_dialog.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});
  final TaskModel task;

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityTextColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red.shade800;
      case 'medium':
        return Colors.orange.shade800;
      case 'low':
        return Colors.green.shade800;
      default:
        return Colors.grey.shade800;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final priorityColor = _getPriorityColor(task.priority);
    final priorityTextColor = _getPriorityTextColor(task.priority);

    return GestureDetector(
      onTap: () {
        taskDetailsDialog(context: context, task: task);
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(100),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      task.priority,
                      style: TextStyle(
                        fontSize: textTheme.labelSmall?.fontSize,
                        fontWeight: FontWeight.bold,
                        color: priorityTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                task.description,
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (task.tags.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: task.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        tag,
                        style: textTheme.labelSmall?.copyWith(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 8),
              Divider(color: Colors.grey.shade300),
              Row(
                mainAxisAlignment: task.status == "Completed"
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        task.status == "Completed"
                            ? Icons.check_circle_rounded
                            : Icons.history_toggle_off_outlined,
                        size: 20,
                        color: task.status == "Completed"
                            ? Colors.green
                            : Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        task.status,
                        style: textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: task.status == "Completed"
                              ? Colors.green
                              : Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  if (task.status != "Completed") ...[
                    Text(
                      "Due: ${DateFormat("d MMM hh:mm a").format(task.dueDate)}",
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
