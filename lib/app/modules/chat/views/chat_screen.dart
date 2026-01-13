import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/chat/controllers/chat_controller.dart';
import 'package:task_manager_firebase/app/routes/app_routes.dart';
import 'user_selection_dialog.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(ChatController());
    final currentUserId = FirebaseServices.auth.currentUser!.uid;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          selectUserDialog();
        },
        label: Text("New"),
        icon: const Icon(Icons.message_outlined),
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              spacing: 10,
              children: [
                Icon(Icons.message_outlined),
                Text(
                  "Chats",
                  style: TextTheme.of(
                    context,
                  ).titleLarge?.copyWith(fontWeight: .bold),
                ),
              ],
            ),
          ),
          Obx(() {
            if (chatController.isLoading.value) {
              return Expanded(
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (chatController.conversations.isEmpty) {
              return Expanded(
                child: Center(child: Text("No Conversation found")),
              );
            }
            return Expanded(
              child: ListView.separated(
                itemCount: chatController.conversations.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final conv = chatController.conversations[index];
                  final otherUser = conv.usersMap.entries
                      .firstWhere((entry) => entry.key != currentUserId)
                      .value;

                  return ListTile(
                    trailing: Column(
                      spacing: 10,
                      crossAxisAlignment: .end,
                      children: [
                        Text("10:30 AM"),
                        CircleAvatar(
                          radius: 10,
                          child: Text("1", style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundImage: otherUser.photoURL != "null"
                          ? NetworkImage(otherUser.photoURL.toString())
                          : AssetImage("assets/images/dummy_profile.png"),
                    ),
                    title: Text(otherUser.displayName),
                    subtitle: Text(conv.lastMessage),
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.chatDetails,
                        arguments: {
                          "conversationId": conv.id,
                          "otherUser": otherUser,
                        },
                      );
                    },
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
