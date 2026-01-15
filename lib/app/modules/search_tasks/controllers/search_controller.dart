import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/home/data/models/task_model.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

class SearchController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<TaskModel> tasks = <TaskModel>[].obs;

  final TextEditingController searchTEController = TextEditingController();

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _subscription;

  @override
  void onInit() {
    super.onInit();
    _loadTasks();
  }


  void _loadTasks() {
    _subscription?.cancel();
    isLoading.value = true;

    _subscription = FirebaseServices.firestore
        .collection('tasks')
        .where(
      'createdBy.uid',
      isEqualTo: FirebaseServices.auth.currentUser!.uid,
    )
        .orderBy('title')
        .snapshots()
        .listen((snapshot) {
      tasks.value = snapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data()))
          .toList();

      isLoading.value = false;
    }, onError: (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    });
  }

  void searchTask() {
    final query = searchTEController.text.trim();

    _subscription?.cancel();
    isLoading.value = true;


    if (query.isEmpty) {
      _loadTasks();
      return;
    }


    _subscription = FirebaseServices.firestore
        .collection('tasks')
        .where(
      'createdBy.uid',
      isEqualTo: FirebaseServices.auth.currentUser!.uid,
    )
        .orderBy('title')
        .startAt([query])
        .endAt(['$query\uf8ff'])
        .snapshots()
        .listen((snapshot) {
      tasks.value = snapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data()))
          .toList();

      isLoading.value = false;
    }, onError: (e) {
      isLoading.value = false;
      Get.snackbar('Search failed', e.toString());
    });
  }

  @override
  void onClose() {
    _subscription?.cancel();
    searchTEController.dispose();
    super.onClose();
  }
}
