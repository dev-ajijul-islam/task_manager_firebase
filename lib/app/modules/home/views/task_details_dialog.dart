import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_firebase/app/modules/auth/data/models/user_model.dart';
import 'package:task_manager_firebase/app/modules/home/controllers/comments_controller.dart';
import 'package:task_manager_firebase/app/modules/home/controllers/task_details_dialog_controller.dart';
import 'package:task_manager_firebase/app/modules/home/data/models/comment_model.dart';
import 'package:task_manager_firebase/app/modules/home/data/models/task_model.dart';
import 'package:task_manager_firebase/app/modules/main_layout/controllers/delete_task_controller.dart';
import 'package:task_manager_firebase/app/modules/main_layout/views/create_or_update_task_dialog.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

void taskDetailsDialog({
  required BuildContext context,
  required TaskModel task,
}) {
  final controller = Get.put(TaskDetailsDialogController());
  final colorScheme = Theme.of(context).colorScheme;
  final CommentsController commentsController = Get.put(CommentsController());
  final DeleteTaskController deleteTaskController = Get.put(
    DeleteTaskController(),
  );

  commentsController.taskModel = task;

  commentsController.loadComments();
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
                    children: [
                      Expanded(
                        child: Text(
                          task.title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              createOrUpdateTaskDialog(
                                context: context,
                                isUpdate: true,
                                task: task,
                              );
                            },
                            child: Container(
                              width: 80,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Icons.edit_calendar_outlined, size: 18),
                                  SizedBox(width: 5),
                                  Text("Edit"),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            color: Colors.red,
                            onPressed: () {
                              Get.dialog(
                                AlertDialog(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: .circular(10),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    Obx(
                                      () => IconButton(
                                        color: Colors.red,
                                        onPressed: () {
                                          deleteTaskController.deleteTask(
                                            taskId: task.id.toString(),
                                          );
                                        },
                                        icon:
                                            deleteTaskController.isLoading.value
                                            ? SizedBox(width: 15,height: 15, child: CircularProgressIndicator())
                                            : Icon(Icons.delete),
                                      ),
                                    ),
                                  ],
                                  title: Text("Delete"),
                                  content: Text(
                                    "Do you want to delete ${task.title}",
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.delete_outline),
                          ),
                        ],
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
                          "Comments",
                          controller.activeTabIndex.value == 1,
                          () => controller.changeTab(1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tab Content
                  Obx(() {
                    if (controller.activeTabIndex.value == 0) {
                      // Details Tab
                      return _buildDetailsTab(
                        task,
                        colorScheme,
                        context,
                        controller,
                      );
                    } else {
                      // Comments Tab
                      return _buildCommentsTab(
                        colorScheme,
                        taskModel: task,
                        commentsController: commentsController,
                      );
                    }
                  }),

                  const SizedBox(height: 20),

                  // Bottom Buttons)
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

// --- Details Tab ---
Widget _buildDetailsTab(
  TaskModel task,
  ColorScheme colorScheme,
  BuildContext context,
  TaskDetailsDialogController controller,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: _buildInfoCard(
              "Priority",
              task.priority,
              colorScheme,
              isBadge: true,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildInfoCard(
              "Due Date",
              DateFormat("d MMM hh:mm a").format(task.dueDate),
              colorScheme,
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildInfoCard(
              "Status",
              task.status,
              colorScheme,
              hasIcon: true,
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Description",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.outlineVariant),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              task.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      // Additional Details Section
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => controller.isShowAdditionalInfo()
                ? const Text(
                    "Additional Details",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                : const SizedBox(),
          ),
          TextButton(
            onPressed: () {
              controller.isShowAdditionalInfo(
                !controller.isShowAdditionalInfo(),
              );
            },
            child: Text(
              "Click To Close",
              style: TextStyle(color: colorScheme.outline, fontSize: 12),
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
                  border: Border.all(color: colorScheme.outlineVariant),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildDetailRow(
                      "Created By :",
                      "${task.createdBy["displayName"]}",
                    ),
                    _buildDetailRow(
                      "Created On :",
                      DateFormat("d MMM y").format(task.createdAt),
                    ),
                    task.updatedAt == null
                        ? const SizedBox()
                        : _buildDetailRow(
                            "Last Updated :",
                            DateFormat("d MMM y").format(task.updatedAt!),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Recurring Task :",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Switch(
                          value: task.isRecurring,
                          activeThumbColor: Colors.white,
                          activeTrackColor: colorScheme.primary,
                          onChanged: (bool value) {},
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : const SizedBox(),
      ),
    ],
  );
}

// --- Comments Tab ---
Widget _buildCommentsTab(
  ColorScheme colorScheme, {
  required TaskModel taskModel,
  required commentsController,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Comments Header
      Text(
        "Comments (${commentsController.comments.length})",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      //  Comment Section
      Form(
        key: formKey,
        child: TextFormField(
          controller: commentsController.commentTEController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Enter your comment";
            }
            return null;
          },
          decoration: .new(
            suffixStyle: .new(color: Colors.blueAccent),
            hintText: "Write your comment...",
            hintStyle: .new(height: 5, fontSize: 14),
            suffixIcon: InkWell(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  commentsController.createComment(
                    CommentModel(
                      user: UserModel(
                        uid: FirebaseServices.auth.currentUser!.uid,
                        displayName: FirebaseServices
                            .auth
                            .currentUser!
                            .displayName
                            .toString(),
                        email: FirebaseServices.auth.currentUser!.email
                            .toString(),
                        photoURL: FirebaseServices.auth.currentUser!.photoURL
                            .toString(),
                      ),
                      comment: commentsController.commentTEController.text
                          .trim(),
                      commentedAt: DateTime.now(),
                      taskId: taskModel.id.toString(),
                    ),
                  );
                }
              },
              child: Icon(Icons.send_outlined, color: Colors.blueAccent),
            ),
          ),
        ),
      ),
      // Comments List
      SizedBox(
        height: 300,
        child: ListView.separated(
          itemCount: commentsController.comments.length,
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemBuilder: (context, index) {
            final comments = commentsController.comments[index];
            return _buildCommentCard(comment: comments);
          },
        ),
      ),

      const SizedBox(height: 20),
    ],
  );
}

// --- Comment Card Widget ---
Widget _buildCommentCard({required CommentModel comment}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade200),
      borderRadius: BorderRadius.circular(12),
      color: Colors.grey.shade50,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // User Avatar
            CircleAvatar(
              backgroundImage: comment.user.photoURL == "null"
                  ? AssetImage("assets/images/dummy_profile.png")
                  : NetworkImage(comment.user.photoURL.toString()),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.user.displayName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    DateFormat("d MMM y h m a").format(comment.commentedAt),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          comment.comment,
          style: const TextStyle(fontSize: 14, height: 1.4),
        ),
      ],
    ),
  );
}

// --- Helper Widgets  ---

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
