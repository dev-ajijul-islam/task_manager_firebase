import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_firebase/app/modules/auth/data/models/user_model.dart';
import 'package:task_manager_firebase/app/modules/chat/controllers/chat_details_controller.dart';
import 'package:task_manager_firebase/app/modules/chat/views/widgets/message_bubble.dart';
import 'package:task_manager_firebase/app/modules/chat/views/widgets/message_input.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

class ChatDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> arguments = Get.arguments;

  ChatDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String conversationId = arguments["conversationId"];
    final UserModel otherUser = arguments["otherUser"];

    final controller = Get.put(
      ChatDetailsController(conversationId: conversationId),
    );
    final textController = TextEditingController();
    final currentUserId = FirebaseServices.auth.currentUser!.uid;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back_ios_sharp),
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: otherUser.photoURL != "null"
                            ? NetworkImage(otherUser.photoURL.toString())
                            : AssetImage("assets/images/dummy_profile.png"),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            otherUser.displayName,
                            style: TextTheme.of(
                              context,
                            ).titleMedium?.copyWith(fontWeight: .bold),
                          ),
                          Text(otherUser.email),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.messages.isEmpty) {
                  return const Center(child: Text("No messages yet."));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final msg = controller.messages[index];
                    final isMe = msg.senderId == currentUserId;
                    final time = DateFormat('hh:mm a').format(msg.createdAt);

                    return MessageBubble(
                      text: msg.text,
                      time: time,
                      isMe: isMe,
                      profile: otherUser.photoURL.toString(),
                    );
                  },
                );
              }),
            ),
            MessageInput(
              controller: textController,
              onSend: () {
                final text = textController.text.trim();
                if (text.isNotEmpty) {
                  controller.sendMessage(text);
                  textController.clear();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
