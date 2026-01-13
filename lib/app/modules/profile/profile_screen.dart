import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/auth/controllers/auth_controller.dart';
import 'package:task_manager_firebase/app/modules/main_layout/controllers/active_task_controller.dart';
import 'package:task_manager_firebase/app/modules/main_layout/controllers/complete_task_controller.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    final ActiveTaskController activeTaskController = Get.put(
      ActiveTaskController(),
    );
    final CompleteTaskController completeTaskController = Get.put(
      CompleteTaskController(),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFE8F6F6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),

              /// PROFILE INFO
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: StreamBuilder(
                  stream: FirebaseServices.auth.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data == null) {
                      return SizedBox();
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: snapshot.data?.photoURL != null
                              ? NetworkImage(snapshot.data!.photoURL.toString())
                              : AssetImage("assets/images/dummy_profile.png"),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${snapshot.data?.displayName}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.email_outlined, size: 16),
                                SizedBox(width: 6),
                                Text(
                                  "${snapshot.data?.email}",
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () {},
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              /// TASK STATS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _StatCard(
                      title: "Tasks Completed",
                      value: "${completeTaskController.completedTasks.length}",
                    ),
                    const SizedBox(width: 12),
                    _StatCard(
                      title: "Tasks Pending",
                      value: "${activeTaskController.activeTasks.length}",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// WHITE CONTAINER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionTitle("Preferences"),
                    _MenuTile(
                      icon: Icons.notifications_outlined,
                      title: "Notifications",
                    ),
                    _Divider(),
                    _MenuTile(
                      icon: Icons.settings_outlined,
                      title: "App Settings",
                    ),

                    const SizedBox(height: 28),

                    _SectionTitle("Support & Information"),
                    _MenuTile(
                      icon: Icons.privacy_tip_outlined,
                      title: "Privacy Policy",
                    ),
                    _Divider(),
                    _MenuTile(icon: Icons.help_outline, title: "FAQs"),

                    const SizedBox(height: 28),

                    _SectionTitle("Account Management"),
                    _MenuTile(
                      icon: Icons.lock_outline,
                      title: "Change Password",
                    ),
                    _Divider(),

                    /// LOG OUT
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: () {
                          authController.signOut();
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.logout, color: Colors.red),
                            SizedBox(width: 10),
                            Text(
                              "Log Out",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// STAT CARD
class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

/// SECTION TITLE
class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

/// MENU TILE
class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const _MenuTile({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 14),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

/// DIVIDER
class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(color: Colors.grey.shade300);
  }
}
