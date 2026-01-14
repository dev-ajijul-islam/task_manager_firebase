import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NotificationsController extends GetxController {
  RxBool isEnabled = false.obs;
  final GetStorage box = GetStorage();

  @override
  void onInit() {
    isEnabled.value = box.read("isEnabled") ?? false;
    super.onInit();
  }

  void toggleNotification(bool value){
    box.write("isEnabled", value);
    isEnabled.value = box.read("isEnabled") ?? false;
  }
}
