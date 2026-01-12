import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/auth/data/models/user_model.dart';
import 'package:task_manager_firebase/app/modules/chat/controllers/chat_controller.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';
import 'package:task_manager_firebase/app/routes/app_routes.dart';

void selectUserDialog() {
  final ChatController chatController = Get.put(ChatController());

  Get.dialog(
    Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: .start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: const Text(
                "Select a User to Continue",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(height: 12),

            // Flexible ensures ListView works inside Column
            Flexible(
              child: FutureBuilder(
                future: FirebaseServices.firestore.collection("users").get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final users = snapshot.data!.docs
                      .where(
                        (u) => u.id != FirebaseServices.auth.currentUser!.uid,
                      )
                      .toList();

                  if (users.isEmpty) {
                    return const Center(child: Text("No users available"));
                  }

                  return ListView.separated(
                    padding: .only(left: 20, bottom: 20),
                    itemCount: users.length,
                    separatorBuilder: (_, _) => SizedBox(),
                    itemBuilder: (context, index) {
                      final user = UserModel.fromJson(users[index].data());
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: user.photoURL != "null"
                              ? NetworkImage(user.photoURL.toString())
                              : AssetImage("assets/images/dummy_profile.png"),
                        ),
                        title: Text(user.displayName),
                        subtitle: Text(user.email),
                        trailing: IconButton(
                          color: ColorScheme.of(context).primary,
                          onPressed: () async {
                            final conversation = await chatController
                                .startConversation(user);
                            Navigator.pop(context);
                            Get.toNamed(
                              AppRoutes.chatDetails,
                              arguments: {
                                "conversationId": conversation.id,
                                "otherUser": user,
                              },
                            );
                          },
                          icon: Icon(Icons.send_outlined),
                        ),
                      );
                    },
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
