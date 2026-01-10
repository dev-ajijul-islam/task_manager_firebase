import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/routes/app_routes.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: .circular(100)),
        onPressed: () {

        },
        child: Icon(Icons.add_circle_outline, size: 30),
      ),
      backgroundColor: ColorScheme.of(context).onPrimary,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                spacing: 10,
                children: [
                  Icon(Icons.chat_outlined, size: 25),
                  Text(
                    "Chats",
                    style: TextTheme.of(
                      context,
                    ).titleLarge?.copyWith(fontWeight: .bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    Get.toNamed(AppRoutes.chatDetails);
                  },
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/150?img=$index",
                    ),
                  ),
                  title: Text("Development team"),
                  subtitle: Text("We need to discuss the upcoming..."),
                  trailing: Column(
                    spacing: 5,
                    crossAxisAlignment: .end,
                    children: [
                      Text("10:30 AM"),
                      CircleAvatar(
                        radius: 10,
                        child: Center(
                          child: Text(
                            "1",
                            style: TextTheme.of(
                              context,
                            ).bodySmall?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
