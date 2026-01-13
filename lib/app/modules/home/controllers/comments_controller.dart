import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/home/data/models/comment_model.dart';
import 'package:task_manager_firebase/app/modules/home/data/models/task_model.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

class CommentsController extends GetxController {
  final TaskModel taskModel;
  RxList<CommentModel> comments = <CommentModel>[].obs;
  RxBool isLoading = true.obs;

  CommentsController({required this.taskModel});

  @override
  void onInit() {
    FirebaseServices.firestore
        .collection("comments")
        .where("user.uid", isEqualTo: FirebaseServices.auth.currentUser?.uid)
        .where("taskId", isEqualTo: taskModel.id)
        .snapshots()
        .map((snapshot) {
          snapshot.docs.map((doc) => CommentModel.fromJson(doc.data()));
          isLoading.value = false;
        }
    );
    super.onInit();
  }

  /// ---------------------create comment-----------------------
  Future<void> createComment(CommentModel comment)async{

  }


}
