import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});
  static String name = "main-layout";

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
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
      body: Center(child: Text("MainLaout")),
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
                IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.calendar_today_outlined),
                ),
              ],
            ),
            Row(
              spacing: 20,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.chat_outlined)),
                IconButton(
                  onPressed: () {},
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
