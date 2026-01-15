import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

class CategoriesController extends GetxController {
  RxBool isLoading = false.obs;

  final RxMap<String, List<Map<String, dynamic>>> tagMap =
      <String, List<Map<String, dynamic>>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() async {
    try {
      isLoading.value = true;

      final snapshot = await FirebaseServices.firestore
          .collection('tasks')
          .where(
            "createdBy.uid",
            isEqualTo: FirebaseServices.auth.currentUser?.uid,
          )
          .get();

      final Map<String, List<Map<String, dynamic>>> tempMap = {};

      for (var doc in snapshot.docs) {
        final tags = List<String>.from(doc.data()['tags'] ?? []);
        for (var tag in tags) {
          if (!tempMap.containsKey(tag)) tempMap[tag] = [];
          tempMap[tag]!.add(doc.data());
        }
      }

      tagMap.value = tempMap;
    } catch (e) {
      debugPrint("Error fetching tasks: $e");
    } finally {
      isLoading.value = false;
    }
  }

  double getProgress(String tag) {
    final tasks = tagMap[tag] ?? [];
    if (tasks.isEmpty) return 0;
    final completed = tasks.where((t) => t['status'] == 'Completed').length;
    return (completed / tasks.length) * 100;
  }

  int getProjectCount(String tag) => tagMap[tag]?.length ?? 0;

  List<String> getAvatars(String tag) {
    final tasks = tagMap[tag] ?? [];
    return tasks
        .map((t) => t['createdBy']?['photoURL'] as String?)
        .whereType<String>()
        .toList();
  }
}
