import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/home/data/models/task_model.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

class SearchController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<TaskModel> tasks = <TaskModel>[].obs;

  final TextEditingController searchTEController = TextEditingController();

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _subscription;

  void searchTask() {
    final query = searchTEController.text.trim();

    _subscription?.cancel();

    if (query.isEmpty) {
      tasks.clear();
      isLoading.value = false;
      return;
    }

    isLoading.value = true;

    _subscription = FirebaseServices.firestore
        .collection('tasks')
        .where(
          "createdBy.uid",
          isEqualTo: FirebaseServices.auth.currentUser?.uid,
        )
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThanOrEqualTo: '$query\uf8ff')
        .snapshots()
        .listen(
          (snapshot) {
            tasks.value = snapshot.docs
                .map((doc) => TaskModel.fromJson(doc.data()))
                .toList();

            isLoading.value = false;
          },
          onError: (e) {
            isLoading.value = false;
            Get.snackbar("Search failed", e.toString());
          },
        );
  }

  @override
  void onClose() {
    _subscription?.cancel();
    searchTEController.dispose();
    super.onClose();
  }
}
