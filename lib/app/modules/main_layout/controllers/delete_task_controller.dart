import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

class DeleteTaskController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> deleteTask({required String taskId}) async {
    isLoading.value = true;
    try {
      await FirebaseServices.firestore.collection("tasks").doc(taskId).delete();

      Get.back();
      Get.back();
      Get.snackbar("Success", "Task deleted");
    } on FirebaseException catch (e) {
      Get.snackbar("Failed", e.message.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
