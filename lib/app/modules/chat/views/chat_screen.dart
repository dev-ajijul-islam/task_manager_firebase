import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/chat/controllers/chat_controller.dart';
import 'package:task_manager_firebase/app/routes/app_routes.dart';
import 'user_selection_dialog.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(ChatController());

    return Scaffold(
      appBar: AppBar(title: const Text("Chats"), elevation: 0.5),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          selectUserDialog();
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (chatController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (chatController.conversations.isEmpty) {
          return const Center(child: Text("No conversations yet."));
        }

        return ListView.separated(
          itemCount: chatController.conversations.length,
          separatorBuilder: (_, _) => const Divider(),
          itemBuilder: (context, index) {
            final conv = chatController.conversations[index];
            final otherUserId = conv.users.firstWhere(
              (uid) => uid != chatController.conversations[index].users.first,
            ); // current user excluded
            return ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
              ),
              title: Text(
                "User",
              ), // Replace with real user data later
              subtitle: Text(conv.lastMessage),
              onTap: () {
                Get.toNamed(
                  AppRoutes.chatDetails,
                  arguments: {
                    "conversationId": conv.id,
                    "otherUserName": "User $otherUserId",
                  },
                );
              },
            );
          },
        );
      }),
    );
  }
}
