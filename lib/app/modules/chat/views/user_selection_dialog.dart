import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/chat/views/chat_details.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';
import 'package:task_manager_firebase/app/modules/chat/controllers/chat_controller.dart';


class UserSelectionDialog extends StatelessWidget {
  const UserSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final chatController = Get.find<ChatController>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Select a User",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: FutureBuilder(
                future: FirebaseServices.firestore
                    .collection("users")
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final users = snapshot.data!.docs
                      .where((u) =>
                  u.id != FirebaseServices.auth.currentUser!.uid)
                      .toList();

                  return ListView.separated(
                    itemCount: users.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            user['photoURL'] ??
                                'https://i.pravatar.cc/150?img=$index',
                          ),
                        ),
                        title: Text(user['displayName'] ?? 'Unknown'),
                        subtitle: Text(user['email'] ?? ''),
                        trailing: ElevatedButton(
                          onPressed: () async {
                            final conversation =
                            await chatController.startConversation(user.id);
                            Navigator.pop(context);
                            // Navigate to chat details
                            Get.to(() => ChatDetailsScreen(
                              conversationId: conversation.id,
                              otherUserName: user['displayName'] ?? '',
                            ));
                          },
                          child: const Text("Start"),
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
    );
  }
}
