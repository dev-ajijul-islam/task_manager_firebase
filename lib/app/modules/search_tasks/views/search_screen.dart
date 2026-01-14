import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/home/views/task_card.dart';
import 'package:task_manager_firebase/app/modules/search_tasks/controllers/search_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchController searchController = Get.put(SearchController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                spacing: 10,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) => searchController.searchTask(),
                      controller: searchController.searchTEController,
                      decoration: .new(
                        prefixIcon: Icon(Icons.search_outlined),
                        hintText: "Search Task by title...",
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Obx(
                  () => ListView.separated(
                    itemBuilder: (context, index) =>
                       TaskCard(task: searchController.tasks[index]),
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: searchController.tasks.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
