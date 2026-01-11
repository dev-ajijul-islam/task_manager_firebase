import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/home/views/categories.dart';
import 'package:task_manager_firebase/app/modules/home/views/task_card.dart';
import 'package:task_manager_firebase/app/modules/home/views/topbar_widget.dart';
import 'package:task_manager_firebase/app/modules/main_layout/controllers/active_task_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ActiveTaskController getTaskController = Get.put(ActiveTaskController());
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
                    if (getTaskController.isLoading.value) {
                      Center(child: CircularProgressIndicator());
                    }
                    if (getTaskController.activeTasks.isEmpty) {
                      return Center(child: Text("Task not found"));
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) => TaskCard(),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemCount: getTaskController.activeTasks.length,
                    );
                  }),
                  ListView.separated(
                    itemBuilder: (context, index) => TaskCard(),
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
