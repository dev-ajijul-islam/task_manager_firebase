import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/home/data/models/comment_model.dart';
import 'package:task_manager_firebase/app/modules/home/data/models/task_model.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

class CommentsController extends GetxController {
  TaskModel? taskModel;
  RxList<CommentModel> comments = <CommentModel>[].obs;
  RxBool isLoading = true.obs;

  final TextEditingController commentTEController = TextEditingController();

  Future<void> loadComments() async {
    FirebaseServices.firestore
        .collection("comments")
        .where("user.uid", isEqualTo: FirebaseServices.auth.currentUser?.uid)
        .where("taskId", isEqualTo: taskModel?.id)
        .snapshots()
        .listen((snapshot) {
          comments.value = snapshot.docs
              .map((doc) => CommentModel.fromJson(doc.data()))
              .toList();
          isLoading.value = false;
        });
  }

  /// ---------------------create comment-----------------------
  Future<void> createComment(CommentModel comment) async {
    isLoading.value = true;
    try {
      FirebaseServices.firestore.collection("comments").add(comment.toJson());
      Get.snackbar("Success", "Commented successfully");
      commentTEController.clear();
      loadComments();
    } on FirebaseException catch (e) {
      Get.snackbar("Failed", "Comment posted");
    } finally {
      isLoading.value = false;
    }
  }
}
