import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_firebase/app/modules/main_layout/controllers/create_task_dialog_controller.dart';

void createTaskDialog({required BuildContext context}) {
  final controller = Get.put(CreateTaskDialogController());

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Dismiss",
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              width: double.infinity,
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Create New Task",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      _buildLabel("Task Title"),
                      _buildTextField(
                        hint: "Enter Task Title",
                        context: context,
                      ),
                      _buildLabel("Description (Optional)"),
                      _buildTextField(
                        hint: "Enter task description..",
                        maxLines: 3,
                        context: context,
                      ),
                      _buildLabel("Due Date"),
                      _buildTextField(
                        context: context,
                        hint: controller.selectedDueDate.value == null
                            ? "Select Date"
                            : DateFormat(
                                'MMM d, yyyy',
                              ).format(controller.selectedDueDate.value!),
                        icon: Icons.calendar_today_outlined,
                        onIconTap: () => controller.selectDate(context, true),
                        readOnly: true,
                      ),
                      _buildLabel("Priority"),
                      _buildDropdownField(
                        value: controller.selectedPriority.value,
                        items: ["Low", "Medium", "High", "Urgent"],
                        onChanged: (val) =>
                            controller.selectedPriority.value = val!,
                      ),
                      _buildLabel("Status"),
                      _buildDropdownField(
                        value: controller.selectedStatus.value,
                        items: ["To Do", "In Process", "Testing", "Completed"],
                        onChanged: (val) =>
                            controller.selectedStatus.value = val!,
                      ),
                      _buildLabel("Tags"),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              hint: "Add Tags (Press Enter)",
                              context: context,
                            ),
                          ),
                          const SizedBox(width: 10),
                          _buildIconButton(Icons.add),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Icon(Icons.sync, size: 20),
                          const SizedBox(width: 8),
                          const Text(
                            "Recurring Task",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Switch(
                            value: controller.isRecurring.value,
                            onChanged: (v) => controller.isRecurring.value = v,
                            activeThumbColor: Colors.white,
                            activeTrackColor: ColorScheme.of(context).primary,
                          ),
                        ],
                      ),
                      if (controller.isRecurring.value) ...[
                        _buildLabel("Frequency"),
                        _buildDropdownField(
                          value: controller.selectedFrequency.value,
                          items: ["Daily", "Weekly", "Monthly", "Yearly"],
                          onChanged: (val) =>
                              controller.selectedFrequency.value = val!,
                        ),
                        _buildLabel("End Date (Optional)"),
                        _buildTextField(
                          context: context,
                          hint: controller.selectedEndDate.value == null
                              ? "dd-mm-yyyy"
                              : DateFormat(
                                  'dd-MM-yyyy',
                                ).format(controller.selectedEndDate.value!),
                          icon: Icons.calendar_today_outlined,
                          onIconTap: () =>
                              controller.selectDate(context, false),
                          readOnly: true,
                        ),
                        const Text(
                          "Leave empty for indefinite recurrence",
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Get.back(),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.black87),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Get.back(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorScheme.of(
                                  context,
                                ).primary,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "Create Task",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 15, bottom: 6),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    ),
  );
}

Widget _buildTextField({
  required String hint,
  int maxLines = 1,
  IconData? icon,
  VoidCallback? onIconTap,
  bool readOnly = false,
  required BuildContext context,
}) {
  return TextField(
    readOnly: readOnly,
    maxLines: maxLines,
    onTap: readOnly ? onIconTap : null,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      suffixIcon: icon != null
          ? GestureDetector(
              onTap: onIconTap,
              child: Icon(icon, color: Colors.grey, size: 20),
            )
          : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: ColorScheme.of(context).primary,
          width: 1.5,
        ),
      ),
    ),
  );
}

Widget _buildDropdownField({
  required String value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200, width: 1.5),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items.map((String val) {
          return DropdownMenuItem<String>(
            value: val,
            child: Text(val, style: const TextStyle(fontSize: 14)),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    ),
  );
}

Widget _buildIconButton(IconData icon) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
    ),
    child: IconButton(
      onPressed: () {},
      icon: Icon(icon, color: Colors.grey),
    ),
  );
}
