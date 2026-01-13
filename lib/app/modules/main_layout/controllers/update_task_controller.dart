import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/home/data/models/task_model.dart';
import 'package:task_manager_firebase/app/modules/main_layout/controllers/create_task_dialog_controller.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

class UpdateTaskController extends GetxController {
  final CreateTaskDialogController createTaskDialogController = Get.put(
    CreateTaskDialogController(),
  );
  var isLoading = false.obs;

  Future<bool> updateTask({required TaskModel task}) async {
    isLoading.value = true;
    try {
      await FirebaseServices.firestore
          .collection("tasks")
          .doc(task.id)
          .set(task.toJson())
          .then((value) {
            return true;
          });
      createTaskDialogController.clearFields();
      return true;
    } on FirebaseException catch (e) {
      Get.snackbar("Failed", e.message.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
