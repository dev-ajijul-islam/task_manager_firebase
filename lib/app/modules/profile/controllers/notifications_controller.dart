import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


@pragma('vm:entry-point')
Future<void> bgHandler(RemoteMessage message) async {
  debugPrint("Background message received:");
  debugPrint("Title: ${message.notification?.title}");
  debugPrint("Body: ${message.notification?.body}");
  debugPrint("Data: ${message.data}");
}

class NotificationsController extends GetxController {
  RxBool isEnabled = true.obs;
  final GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    isEnabled.value = box.read("isEnabled") ?? false;
    if (isEnabled.value) {
      _initFCM();
    }
  }

  void toggleNotification(bool value) {
    if (value) {
      _initFCM();
      isEnabled.value = value;
      box.write("isEnabled", value);
    } else {
      FirebaseMessaging.instance.unsubscribeFromTopic("all");
      isEnabled.value = false;
    }
  }

  void _initFCM() async {
    NotificationSettings settings = await FirebaseMessaging.instance
        .requestPermission(
          alert: true,
          announcement: true,
          badge: true,
          carPlay: true,
          criticalAlert: true,
          provisional: true,
          sound: true,
          providesAppNotificationSettings: true,
        );

    if (settings.authorizationStatus != AuthorizationStatus.authorized &&
        settings.authorizationStatus != AuthorizationStatus.provisional) {
      isEnabled.value = false;
      box.write("isEnabled", false);
      return;
    }

    await FirebaseMessaging.instance.subscribeToTopic("all");

    FirebaseMessaging.onMessage.listen((message) => _handleMessage(message));
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) => _handleMessage(message),
    );
    FirebaseMessaging.onBackgroundMessage(bgHandler);
  }

  void _handleMessage(RemoteMessage message) {
    debugPrint("Notification received:");
    debugPrint("Title: ${message.notification?.title}");
    debugPrint("Body: ${message.notification?.body}");
    debugPrint("Data: ${message.data}");
  }
}
