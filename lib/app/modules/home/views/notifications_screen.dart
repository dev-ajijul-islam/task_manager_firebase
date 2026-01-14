import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_firebase/app/modules/home/data/models/notification_model.dart';
import 'package:task_manager_firebase/app/modules/profile/controllers/notifications_controller.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final NotificationsController notificationsController = Get.put(
    NotificationsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                spacing: 10,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  Text(
                    "Notifications",
                    style: TextTheme.of(context).titleLarge,
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Expanded(
                child: Obx(
                  () {
                    if(notificationsController.isLoading.value){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    if(notificationsController.notifications.isEmpty){
                      return Center(child: Text("No notifications"),);
                    }
                    return ListView.separated(
                    itemBuilder: (context, index) {
                      final NotificationModel notification =
                          notificationsController.notifications[index];
                      return ListTile(
                        tileColor: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(borderRadius: .circular(10)),
                        leading: Icon(Icons.notifications_active_outlined,color: Colors.orangeAccent,),
                        title: Text(notification.title.toString()),
                        subtitle: Text(notification.text.toString()),
                        trailing: Text(
                          DateFormat("h m a").format(notification.createdAt),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: notificationsController.notifications.length,
                  );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
