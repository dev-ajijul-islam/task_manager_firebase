import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      decoration: .new(
                        prefixIcon: Icon(Icons.search_outlined),
                        hintText: "Search Task by title...",
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: ListView()),
            ],
          ),
        ),
      ),
    );
  }
}
