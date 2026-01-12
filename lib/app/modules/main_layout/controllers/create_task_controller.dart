import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/home/data/models/task_model.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

class CreateTaskController extends GetxController {
  var isLoading = false.obs;

  Future<bool> createTask({required TaskModel task}) async {
    isLoading.value = true;
    try {
      await FirebaseServices.firestore
          .collection("tasks")
          .add(task.toJson())
          .then((value) {
            return true;
          });
      return true;
    } on FirebaseException catch (e) {
      Get.snackbar("Failed", e.message.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
