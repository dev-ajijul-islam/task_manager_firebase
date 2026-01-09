import 'package:flutter/material.dart';
import 'package:task_manager_firebase/app/modules/calender/views/calender_screen.dart';
import 'package:task_manager_firebase/app/modules/chat/views/chat_screen.dart';
import 'package:task_manager_firebase/ui/screens/main_layout/home_screen.dart';
import 'package:task_manager_firebase/app/modules/profile/profile_screen.dart';
import 'package:task_manager_firebase/app/modules/main_layout/views/create_task_dialog.dart';
import 'package:task_manager_firebase/app/modules/home/views/topbar_widget.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});
  static String name = "main-layout";

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentScreenIndex = 0;

  final List<Widget> screen = [
    HomeScreen(),
    CalenderScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      floatingActionButtonLocation: .centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: .circular(100)),
        onPressed: () {
          createTaskDialog(context: context);
        },
        child: Icon(Icons.add_circle_outline, size: 30),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TopbarWidget(),
            Expanded(child: screen[_currentScreenIndex]),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        elevation: 5,
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Row(
              spacing: 20,
              children: [
                IconButton(
                  color: _currentScreenIndex == 0
                      ? ColorScheme.of(context).primary
                      : null,
                  onPressed: () {
                    setState(() {
                      _currentScreenIndex = 0;
                    });
                  },
                  icon: Icon(Icons.add_home_outlined),
                ),
                IconButton(
                  color: _currentScreenIndex == 1
                      ? ColorScheme.of(context).primary
                      : null,
                  onPressed: () {
                    setState(() {
                      _currentScreenIndex = 1;
                    });
                  },
                  icon: Icon(Icons.calendar_month_outlined),
                ),
              ],
            ),
            Row(
              spacing: 20,
              children: [
                IconButton(
                  color: _currentScreenIndex == 2
                      ? ColorScheme.of(context).primary
                      : null,
                  onPressed: () {
                    setState(() {
                      _currentScreenIndex = 2;
                    });
                  },
                  icon: Icon(Icons.chat_outlined),
                ),
                IconButton(
                  color: _currentScreenIndex == 3
                      ? ColorScheme.of(context).primary
                      : null,
                  onPressed: () {
                    setState(() {
                      _currentScreenIndex = 3;
                    });
                  },
                  icon: Icon(Icons.person_2_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
