import 'package:get/get.dart';

class TaskDetailsDialogController extends GetxController {
  var activeTabIndex = 0.obs;
  var isShowAdditionalInfo = false.obs;
  var isRecurring = true.obs;

  void changeTab(int index) => activeTabIndex.value = index;
}
