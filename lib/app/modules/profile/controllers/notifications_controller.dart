import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_manager_firebase/app/modules/home/data/models/notification_model.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

@pragma('vm:entry-point')
Future<void> bgHandler(RemoteMessage message) async {
  debugPrint("Background message received:");
  debugPrint("Title: ${message.notification?.title}");
  debugPrint("Body: ${message.notification?.body}");
  debugPrint("Data: ${message.data}");

  await createNotification(message);
}

Future<void> createNotification(RemoteMessage message) async {
  final NotificationModel notification = NotificationModel(
    title: message.notification?.title,
    text: message.notification?.body,
    createdAt: DateTime.now(),
    userId: FirebaseServices.auth.currentUser!.uid,
  );
  FirebaseServices.firestore
      .collection("notifications")
      .add(notification.toJson());
}

class NotificationsController extends GetxController {
  RxBool isEnabled = true.obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  final GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    isEnabled.value = box.read("isEnabled") ?? false;
    if (isEnabled.value) {
      _initFCM();
      _loadNotifications();
    }
  }

  Future<void> _loadNotifications() async {
    FirebaseServices.firestore
        .collection("notifications")
        .where("userId", isEqualTo: FirebaseServices.auth.currentUser?.uid)
        .snapshots()
        .listen(
          (snapshot) => snapshot.docs.map(
            (doc) => notifications.add(NotificationModel.fromJson(doc.data())),
          ),
        );
  }

  void toggleNotification(bool value) {
    isEnabled.value = value;
    box.write("isEnabled", value);
    if (value) {
      _initFCM();
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

  void _handleMessage(RemoteMessage message) async {
    debugPrint("Notification received:");
    debugPrint("Title: ${message.notification?.title}");
    debugPrint("Body: ${message.notification?.body}");
    debugPrint("Data: ${message.data}");

    await createNotification(message);
  }
}
