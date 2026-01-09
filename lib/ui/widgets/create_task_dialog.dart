import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

void createTaskDialog({required BuildContext context}) {

  DateTime? selectedDueDate;
  DateTime? selectedEndDate;
  String selectedPriority = "Medium";
  String selectedStatus = "In Process";
  String selectedFrequency = "Weekly";
  bool isRecurring = true;

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Dismiss",
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) {

      return StatefulBuilder(
        builder: (context, setState) {

 
          Future<void> selectDate(BuildContext context, bool isDueDate) async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null) {
              setState(() {
                if (isDueDate) {
                  selectedDueDate = picked;
                } else {
                  selectedEndDate = picked;
                }
              });
            }
          }

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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Create New Task",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close),
                            )
                          ],
                        ),

                        _buildLabel("Task Title"),
                        _buildTextField(hint: "Enter Task Title"),

                        _buildLabel("Description (Optional)"),
                        _buildTextField(hint: "Enter task description..", maxLines: 3),

                        _buildLabel("Due Date"),
                        _buildTextField(
                          hint: selectedDueDate == null
                              ? "Select Date"
                              : DateFormat('MMM d, yyyy').format(selectedDueDate!),
                          icon: Icons.calendar_today_outlined,
                          onIconTap: () => selectDate(context, true),
                          readOnly: true,
                        ),

                        _buildLabel("Priority"),
                        _buildDropdownField(
                          value: selectedPriority,
                          items: ["Low", "Medium", "High", "Urgent"],
                          onChanged: (val) => setState(() => selectedPriority = val!),
                        ),

                        _buildLabel("Status"),
                        _buildDropdownField(
                          value: selectedStatus,
                          items: ["To Do", "In Process", "Testing", "Completed"],
                          onChanged: (val) => setState(() => selectedStatus = val!),
                        ),

                        _buildLabel("Tags"),
                        Row(
                          children: [
                            Expanded(child: _buildTextField(hint: "Add Tags (Press Enter)")),
                            const SizedBox(width: 10),
                            _buildIconButton(Icons.add),
                          ],
                        ),

                        const SizedBox(height: 15),

                     
                        Row(
                          children: [
                            const Icon(Icons.sync, size: 20),
                            const SizedBox(width: 8),
                            const Text("Recurring Task", style: TextStyle(fontWeight: FontWeight.w600)),
                            const Spacer(),
                            Switch(
                              value: isRecurring,
                              onChanged: (v) => setState(() => isRecurring = v),
                              activeThumbColor: Colors.white,
                              activeTrackColor: Colors.indigoAccent[700],
                            ),
                          ],
                        ),

                        if (isRecurring) ...[
                          _buildLabel("Frequency"),
                          _buildDropdownField(
                            value: selectedFrequency,
                            items: ["Daily", "Weekly", "Monthly", "Yearly"],
                            onChanged: (val) => setState(() => selectedFrequency = val!),
                          ),

                          _buildLabel("End Date (Optional)"),
                          _buildTextField(
                            hint: selectedEndDate == null
                                ? "dd-mm-yyyy"
                                : DateFormat('dd-MM-yyyy').format(selectedEndDate!),
                            icon: Icons.calendar_today_outlined,
                            onIconTap: () => selectDate(context, false),
                            readOnly: true,
                          ),
                          const Text("Leave empty for indefinite recurrence", style: TextStyle(fontSize: 11, color: Colors.grey)),
                        ],

                        const SizedBox(height: 25),

                     
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.pop(context),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Text("Cancel", style: TextStyle(color: Colors.black87)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                             
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigoAccent[700],
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Text("Create Task", style: TextStyle(color: Colors.white)),
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
          );
        },
      );
    },
  );
}

// --- Helper Widgets ---

Widget _buildLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 15, bottom: 6),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
  );
}

Widget _buildTextField({
  required String hint,
  int maxLines = 1,
  IconData? icon,
  VoidCallback? onIconTap,
  bool readOnly = false,
}) {
  return TextField(
    readOnly: readOnly,
    maxLines: maxLines,
    onTap: readOnly ? onIconTap : null,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      suffixIcon: icon != null
          ? GestureDetector(onTap: onIconTap, child: Icon(icon, color: Colors.grey, size: 20))
          : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.indigo, width: 1.5),
      ),
    ),
  );
}

Widget _buildDropdownField({
  required String value,
  required List<String> items,
  required ValueChanged<String?> onChanged
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
              child: Text(val, style: const TextStyle(fontSize: 14))
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
    child: IconButton(onPressed: () {}, icon: Icon(icon, color: Colors.grey)),
  );
}