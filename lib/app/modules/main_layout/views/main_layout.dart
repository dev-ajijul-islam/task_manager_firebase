import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/main_layout/controllers/layout_controller.dart';
import 'package:task_manager_firebase/app/modules/main_layout/views/create_task_dialog.dart';
import 'package:task_manager_firebase/app/modules/home/views/topbar_widget.dart';

class MainLayout extends StatelessWidget {
  MainLayout({super.key});
  final LayoutController layoutController = Get.put(LayoutController());

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = layoutController.screens;
    var currentScreenIndex = layoutController.currentScreenIndex;
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
        child: Obx(() => Expanded(child: screens[currentScreenIndex()])),
      ),
      bottomNavigationBar: Obx(
        () => BottomAppBar(
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
                    color: currentScreenIndex() == 0
                        ? ColorScheme.of(context).primary
                        : null,
                    onPressed: () {
                      currentScreenIndex(0);
                    },
                    icon: Icon(Icons.add_home_outlined),
                  ),
                  IconButton(
                    color: currentScreenIndex() == 1
                        ? ColorScheme.of(context).primary
                        : null,
                    onPressed: () {
                      currentScreenIndex(1);
                    },
                    icon: Icon(Icons.calendar_month_outlined),
                  ),
                ],
              ),
              Row(
                spacing: 20,
                children: [
                  IconButton(
                    color: currentScreenIndex() == 2
                        ? ColorScheme.of(context).primary
                        : null,
                    onPressed: () {
                      currentScreenIndex(2);
                    },
                    icon: Icon(Icons.chat_outlined),
                  ),
                  IconButton(
                    color: currentScreenIndex() == 3
                        ? ColorScheme.of(context).primary
                        : null,
                    onPressed: () {
                      currentScreenIndex(3);
                    },
                    icon: Icon(Icons.person_2_outlined),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
