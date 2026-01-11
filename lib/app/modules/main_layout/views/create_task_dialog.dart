import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_firebase/app/modules/home/data/models/task_model.dart';
import 'package:task_manager_firebase/app/modules/main_layout/controllers/create_task_controller.dart';
import 'package:task_manager_firebase/app/modules/main_layout/controllers/create_task_dialog_controller.dart';

void createTaskDialog({required BuildContext context}) {
  final CreateTaskDialogController dialogController = Get.put(
    CreateTaskDialogController(),
  );
  final CreateTaskController createTaskController = Get.put(
    CreateTaskController(),
  );

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                  () => Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// HEADER
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
                          controller: dialogController.titleController,
                          hint: "Enter Task Title",
                          context: context,
                          validator: (v) =>
                              v!.isEmpty ? "Title is required" : null,
                        ),

                        _buildLabel("Description (Optional)"),
                        _buildTextField(
                          controller: dialogController.descriptionController,
                          hint: "Enter task description..",
                          maxLines: 3,
                          context: context,
                        ),

                        _buildLabel("Due Date"),
                        _buildTextField(
                          controller: dialogController.dueDateController,
                          context: context,
                          hint: dialogController.selectedDueDate.value == null
                              ? "Select Date"
                              : DateFormat('MMM d, yyyy').format(
                                  dialogController.selectedDueDate.value!,
                                ),
                          icon: Icons.calendar_today_outlined,
                          onIconTap: () =>
                              dialogController.selectDate(context, true),
                          readOnly: true,
                          validator: (v) =>
                              v!.isEmpty ? "Due date required" : null,
                        ),

                        _buildLabel("Priority"),
                        _buildDropdownField(
                          value: dialogController.selectedPriority.value,
                          items: ["Low", "Medium", "High", "Urgent"],
                          onChanged: (v) =>
                              dialogController.selectedPriority.value = v!,
                        ),

                        _buildLabel("Status"),
                        _buildDropdownField(
                          value: dialogController.selectedStatus.value,
                          items: [
                            "To Do",
                            "In Process",
                            "Testing",
                            "Completed",
                          ],
                          onChanged: (v) =>
                              dialogController.selectedStatus.value = v!,
                        ),

                        _buildLabel("Tags"),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: dialogController.tagsController,
                                hint: "Add Tags (Press Enter)",
                                context: context,
                              ),
                            ),
                            const SizedBox(width: 10),
                            _buildIconButton(Icons.add),
                          ],
                        ),

                        const SizedBox(height: 15),

                        /// RECURRING
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
                              value: dialogController.isRecurring.value,
                              onChanged: (v) =>
                                  dialogController.isRecurring.value = v,
                            ),
                          ],
                        ),

                        if (dialogController.isRecurring.value) ...[
                          _buildLabel("Frequency"),
                          _buildDropdownField(
                            value: dialogController.selectedFrequency.value,
                            items: ["Daily", "Weekly", "Monthly", "Yearly"],
                            onChanged: (v) =>
                                dialogController.selectedFrequency.value = v!,
                          ),

                          _buildLabel("End Date (Optional)"),
                          _buildTextField(
                            controller: dialogController.endDateController,
                            context: context,
                            hint: dialogController.selectedEndDate.value == null
                                ? "dd-mm-yyyy"
                                : DateFormat('dd-MM-yyyy').format(
                                    dialogController.selectedEndDate.value!,
                                  ),
                            icon: Icons.calendar_today_outlined,
                            onIconTap: () =>
                                dialogController.selectDate(context, false),
                            readOnly: true,
                          ),

                          const Text(
                            "Leave empty for indefinite recurrence",
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],

                        const SizedBox(height: 25),

                        /// ACTIONS
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Get.back(),
                                child: const Text("Cancel"),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Obx(
                                () => ElevatedButton(
                                  onPressed:
                                      createTaskController.isLoading.value
                                      ? null
                                      : () {
                                          if (!formKey.currentState!.validate())
                                            return;

                                          createTaskController.createTask(
                                            task: TaskModel(
                                              title: dialogController
                                                  .titleController
                                                  .text
                                                  .trim(),
                                              description: dialogController
                                                  .descriptionController
                                                  .text
                                                  .trim(),
                                              dueDate: dialogController
                                                  .selectedDueDate
                                                  .value!,
                                              priority: dialogController
                                                  .selectedPriority
                                                  .value,
                                              status: dialogController
                                                  .selectedStatus
                                                  .value,
                                              tags: [
                                                dialogController
                                                    .tagsController
                                                    .text
                                                    .trim(),
                                              ],
                                              frequency: dialogController
                                                  .selectedFrequency
                                                  .value,
                                              endDate: dialogController
                                                  .selectedEndDate
                                                  .value,
                                            ),
                                          );
                                        },

                                  child: createTaskController.isLoading.value
                                      ? const SizedBox(
                                          height: 18,
                                          width: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text("Create Task"),
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
        ),
      );
    },
  );
}

/// ---------- WIDGETS ----------

Widget _buildLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 15, bottom: 6),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
  );
}

Widget _buildTextField({
  required TextEditingController controller,
  required String hint,
  int maxLines = 1,
  IconData? icon,
  VoidCallback? onIconTap,
  bool readOnly = false,
  String? Function(String?)? validator,
  required BuildContext context,
}) {
  return TextFormField(
    controller: controller,
    maxLines: maxLines,
    readOnly: readOnly,
    validator: validator,
    onTap: readOnly ? onIconTap : null,
    decoration: InputDecoration(
      hintText: hint,
      suffixIcon: icon != null
          ? GestureDetector(onTap: onIconTap, child: Icon(icon, size: 20))
          : null,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}

Widget _buildDropdownField({
  required String value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    items: items
        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
        .toList(),
    onChanged: onChanged,
    decoration: const InputDecoration(border: OutlineInputBorder()),
  );
}

Widget _buildIconButton(IconData icon) {
  return IconButton(onPressed: () {}, icon: Icon(icon));
}
