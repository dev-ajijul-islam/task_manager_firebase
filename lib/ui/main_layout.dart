import 'package:flutter/material.dart';
import 'package:task_manager_firebase/ui/screens/main_layout/calender_screen.dart';
import 'package:task_manager_firebase/ui/screens/main_layout/chat_screen.dart';
import 'package:task_manager_firebase/ui/screens/main_layout/home_screen.dart';
import 'package:task_manager_firebase/ui/screens/main_layout/profile_screen.dart';
import 'package:task_manager_firebase/ui/widgets/topbar_widget.dart';

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
        onPressed: () {},
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
                  onPressed: () {
                    setState(() {
                      _currentScreenIndex = 0;
                    });
                  },
                  icon: Icon(Icons.home),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _currentScreenIndex = 1;
                    });
                  },
                  icon: Icon(Icons.calendar_today_outlined),
                ),
              ],
            ),
            Row(
              spacing: 20,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _currentScreenIndex = 2;
                    });
                  },
                  icon: Icon(Icons.chat_outlined),
                ),
                IconButton(
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
