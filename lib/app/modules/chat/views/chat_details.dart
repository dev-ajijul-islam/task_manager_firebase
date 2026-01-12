import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_firebase/app/modules/chat/controllers/chat_details_controller.dart';
import 'package:task_manager_firebase/app/modules/chat/views/widgets/message_bubble.dart';
import 'package:task_manager_firebase/app/modules/chat/views/widgets/message_input.dart';

class ChatDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> arguments = Get.arguments;

  ChatDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String conversationId = arguments["conversationId"];
    final String otherUserName = arguments["otherUserName"];

    final controller = Get.put(
      ChatDetailsController(conversationId: conversationId),
    );
    final textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text(otherUserName), elevation: 0.5),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.messages.isEmpty) {
                return const Center(child: Text("No messages yet."));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final msg = controller.messages[index];
                  final isMe =
                      msg.senderId ==
                      controller.messages[index].senderId; // For demo
                  final time = DateFormat('hh:mm a').format(msg.createdAt);
                  return MessageBubble(text: msg.text, time: time, isMe: isMe);
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
    );
  }
}
