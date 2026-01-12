import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/home/data/models/task_model.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

class ActiveTaskController extends GetxController {
  RxList<TaskModel> activeTasks = <TaskModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    FirebaseServices.firestore
        .collection("tasks")
        .where("createdBy.uid", isEqualTo: FirebaseServices.auth.currentUser?.uid)
        .where("status", whereIn: ["In Process", "To Do", "Testing"])
        .snapshots()
        .listen(
          (snapshot) {
            activeTasks.value = snapshot.docs
                .map((doc) => TaskModel.fromJson(doc.data()))
                .toList();
            isLoading.value = false;
          },
          onError: (e) {
            isLoading.value = false;
          },
        );
  }
}
