import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  "Design task dashboard",
                  style: TextTheme.of(context).titleMedium,
                ),
                Chip(
                  label: Text(
                    "Medium",
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
            Text("Create wireframes and mockup for the main dashboard"),
            Row(
              spacing: 10,
              children: [
                Text("UI", style: TextTheme.of(context).titleMedium),
                Text("Design", style: TextTheme.of(context).titleMedium),
              ],
            ),
            Divider(color: Colors.grey.shade300),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Row(
                  spacing: 5,
                  children: [
                    Icon(Icons.history_toggle_off_outlined, size: 20),
                    Text("In progress"),
                  ],
                ),
                Text("Due Date : 10 May"),
              ],
            ),
          ],
        ),
      ),
    );;
  }
}
