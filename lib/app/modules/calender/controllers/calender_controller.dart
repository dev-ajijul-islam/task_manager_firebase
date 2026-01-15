import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_firebase/app/modules/home/data/models/task_model.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

class CalenderController extends GetxController {

  RxList<TaskModel> allTasks = <TaskModel>[].obs;

  final RxMap<String, List<TaskModel>> tasks =
      <String, List<TaskModel>>{}.obs;

  RxBool isLoading = true.obs;

  final focusedDay = DateTime.now().obs;

  final months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ].obs;

  @override
  void onInit() {
    super.onInit();
    _listenTasks();
  }

  void _listenTasks() {
    FirebaseServices.firestore
        .collection("tasks")
        .where(
      "createdBy.uid",
      isEqualTo: FirebaseServices.auth.currentUser?.uid,
    )
        .snapshots()
        .listen(
          (snapshot) {
        allTasks.value =
            snapshot.docs.map((e) => TaskModel.fromJson({...e.data(),"id": e.id})).toList();

        _buildTaskMap();
        isLoading.value = false;
      },
      onError: (_) {
        isLoading.value = false;
      },
    );
  }

  void _buildTaskMap() {
    final Map<String, List<TaskModel>> temp = {};

    for (final task in allTasks) {
      final key = DateFormat("y-M-d").format(task.dueDate);

      if (!temp.containsKey(key)) {
        temp[key] = [];
      }
      temp[key]!.add(task);
    }

    tasks.assignAll(temp);
  }

  List<TaskModel> taskForDay(DateTime day) {
    final key = DateFormat("y-M-d").format(day);
    return tasks[key] ?? [];
  }

  void changeMonth(int month) {
    focusedDay.value = DateTime(focusedDay.value.year, month, 1);
  }

  void onPageChanged(DateTime day) {
    focusedDay.value = day;
  }
}
