import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/home/controllers/task_details_dialog_controller.dart';

void taskDetailsDialog({required BuildContext context}) {
  final controller = Get.put(TaskDetailsDialogController());
  final colorScheme = Theme.of(context).colorScheme;

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Dismiss",
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 5,
                    children: [
                      const Expanded(
                        child: Text(
                          "Design Task Management Dashboard",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: .circular(10),
                          border: .all(color: Colors.grey),
                        ),

                        child: Row(
                          spacing: 5,
                          mainAxisAlignment: .center,
                          crossAxisAlignment: .center,
                          children: [
                            Icon(Icons.edit_calendar_outlined, size: 18),
                            Text("Edit"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => Row(
                      children: [
                        _buildTab(
                          "Details",
                          controller.activeTabIndex.value == 0,
                          () => controller.changeTab(0),
                        ),
                        const SizedBox(width: 10),
                        _buildTab(
                          "Comments(2)",
                          controller.activeTabIndex.value == 1,
                          () => controller.changeTab(1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          "Priority",
                          "High",
                          colorScheme,
                          isBadge: true,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoCard(
                          "Due Date",
                          "May 10, 2025",
                          colorScheme,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: .start,
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          "Status",
                          "In Progress",
                          colorScheme,
                          hasIcon: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Description",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: colorScheme.outlineVariant,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Create wireframes and mockups for the main dashboard",
                            style: TextTheme.of(context).bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),

                  // Additional Details Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => controller.isShowAdditionalInfo()
                            ? const Text(
                                "Additional Details",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              )
                            : SizedBox(),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.isShowAdditionalInfo(
                            !controller.isShowAdditionalInfo(),
                          );
                        },
                        child: Text(
                          "Click To Close",
                          style: TextStyle(
                            color: colorScheme.outline,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => controller.isShowAdditionalInfo()
                        ? Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: colorScheme.outlineVariant,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                _buildDetailRow("Created By :", "Rahul Sharma"),
                                _buildDetailRow("Created On :", "Apr 21, 2025"),
                                _buildDetailRow(
                                  "Last Updated :",
                                  "Apr 21, 2025",
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Recurring Task :",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Switch(
                                      value: controller.isRecurring.value,
                                      onChanged: (v) =>
                                          controller.isRecurring.value = v,
                                      activeThumbColor: Colors.white,
                                      activeTrackColor: ColorScheme.of(
                                        context,
                                      ).primary,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                  ),
                  const SizedBox(height: 20),

                  // Bottom Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.check_circle_outline,
                            size: 18,
                          ),
                          label: const Text("Mark As Done"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff99f6ca),
                            foregroundColor: const Color(0xff065f46),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey.shade100,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Close",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

// --- Helper Widgets ---

Widget _buildTab(String label, bool isActive, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: isActive ? Border.all(width: 0) : null,
        boxShadow: isActive
            ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)]
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.black : Colors.grey,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    ),
  );
}

Widget _buildInfoCard(
  String label,
  String value,
  ColorScheme colorScheme, {
  bool isBadge = false,
  bool hasIcon = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      const SizedBox(height: 4),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(12),
        ),
        child: hasIcon
            ? Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: colorScheme.primary),
                  const SizedBox(width: 5),
                  Text(
                    value,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              )
            : isBadge
            ? UnconstrainedBox(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xfffef9c3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    value,
                    style: const TextStyle(
                      color: Color(0xff854d0e),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            : Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
      ),
    ],
  );
}

Widget _buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );
}
