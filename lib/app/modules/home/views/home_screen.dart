import 'package:flutter/material.dart';
import 'package:task_manager_firebase/app/modules/home/views/categories.dart';
import 'package:task_manager_firebase/app/modules/home/views/task_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: .start,
          children: [
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
                  ListView.separated(
                    itemBuilder: (context, index) => TaskCard(),
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: 10,
                  ),   ListView.separated(
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
