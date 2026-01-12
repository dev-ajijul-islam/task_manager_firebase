import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/home/views/categories.dart';
import 'package:task_manager_firebase/app/modules/home/views/task_card.dart';
import 'package:task_manager_firebase/app/modules/home/views/topbar_widget.dart';
import 'package:task_manager_firebase/app/modules/main_layout/controllers/active_task_controller.dart';
import 'package:task_manager_firebase/app/modules/main_layout/controllers/complete_task_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ActiveTaskController activeTaskController = Get.put(
      ActiveTaskController(),
    );
    final CompleteTaskController completeTaskController = Get.put(
      CompleteTaskController(),
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: .start,
          children: [
            TopbarWidget(),
            Categories(),
            TabBar(
              dividerHeight: 0,
              indicator: BoxDecoration(shape: BoxShape.rectangle),
              tabs: [
                Tab(child: Text("Active")),
                Tab(child: Text("Completed")),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Obx(() {
                    if (activeTaskController.isLoading.value) {
                      Center(child: CircularProgressIndicator());
                    }
                    if (activeTaskController.activeTasks.isEmpty) {
                      return Center(child: Text("Task not found"));
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) => TaskCard(task: activeTaskController.activeTasks[index],),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemCount: activeTaskController.activeTasks.length,
                    );
                  }),
                  Obx(() {
                    if (completeTaskController.isLoading.value) {
                      Center(child: CircularProgressIndicator());
                    }
                    if (completeTaskController.completedTasks.isEmpty) {
                      return Center(child: Text("Task not found"));
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) => TaskCard(task: completeTaskController.completedTasks[index],),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemCount: completeTaskController.completedTasks.length,
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
