import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/home/data/models/task_model.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

class SearchController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<TaskModel> tasks = <TaskModel>[].obs;
  TextEditingController searchTEController = TextEditingController();

  Future<void> searchTask() async {
    isLoading.value = true;
    try {
      FirebaseServices.firestore
          .collection('tasks')
          .where(
            "createdBy.uid",
            isEqualTo: FirebaseServices.auth.currentUser?.uid,
          )
          .where(
            'title',
            isGreaterThanOrEqualTo: searchTEController.text.trim(),
          )
          .where(
            'title',
            isLessThanOrEqualTo: '${searchTEController.text.trim()}\uf8ff',
          )
          .snapshots()
          .listen(
            (snapshot) => tasks.value = snapshot.docs
                .map((doc) => TaskModel.fromJson(doc.data()))
                .toList(),
          );
    } on FirebaseException catch (e) {
      Get.snackbar("Failed", e.message.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
