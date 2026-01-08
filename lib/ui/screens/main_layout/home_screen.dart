import 'package:flutter/material.dart';
import 'package:task_manager_firebase/ui/widgets/categories.dart';
import 'package:task_manager_firebase/ui/widgets/task_card.dart';

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text("My Tasks", style: TextTheme.of(context).titleLarge),
            ),
            TabBar(
              dividerHeight: 1,
              dividerColor: Colors.grey.shade200,
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
                    padding: .symmetric(horizontal: 20, vertical: 10),
                    itemBuilder: (context, index) => TaskCard(),
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: 10,
                  ),
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
