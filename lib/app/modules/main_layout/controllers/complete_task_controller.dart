import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/home/data/models/task_model.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

class CompleteTaskController extends GetxController {
  var isLoading = false.obs;
  RxList<TaskModel> completedTasks = <TaskModel>[].obs;

  @override
  void onInit() {
    FirebaseServices.firestore
        .collection("tasks")
        .where("createdBy.uid", isEqualTo: FirebaseServices.auth.currentUser?.uid)
        .where("status", isEqualTo: "Completed")
        .snapshots()
        .listen(
          (snapshot) {
            completedTasks.value = snapshot.docs
                .map((doc) => TaskModel.fromJson(doc.data()))
                .toList();

            isLoading.value = false;
          },
          onError: (e) {
            isLoading.value = false;
          },
        );
    super.onInit();
  }
}
