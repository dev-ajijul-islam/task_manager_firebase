import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:task_manager_firebase/app/modules/home/controllers/categories_controller.dart';
import 'package:task_manager_firebase/app/routes/app_routes.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoriesController());

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Categories", style: Theme.of(context).textTheme.titleLarge),
              TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.searchScreen);
                },
                child: Text("See All"),
              ),
            ],
          ),
        ),
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.tagMap.isEmpty) {
            return const Center(child: Text("No categories found"));
          }

          final tags = controller.tagMap.keys.toList();

          return CarouselSlider(
            items: tags.map((tag) {
              final progress = controller.getProgress(tag);
              final projectCount = controller.getProjectCount(tag);
              final avatars = controller.getAvatars(tag);

              return Card(
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsets.all(10),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.primary,
                              Colors.purpleAccent.shade100.withAlpha(150),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tag,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                              Text(
                                "$projectCount Projects",
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 5,
                          bottom: 5,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${progress.toStringAsFixed(0)}%",
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(fontSize: 17, height: 1),
                            ),
                            Row(
                              spacing: 10,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: LinearProgressBar(
                                    maxSteps: 100,
                                    progressType: ProgressType.linear,
                                    currentStep: progress.toInt(),
                                    progressColor: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    backgroundColor: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                    minHeight: 2,
                                  ),
                                ),

                                if (avatars.isNotEmpty)
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundImage: NetworkImage(avatars[0]),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            options: CarouselOptions(
              aspectRatio: 2.4,
              viewportFraction: 0.55,
              disableCenter: true,
              pageSnapping: false,
              enableInfiniteScroll: false,
              padEnds: false,
            ),
          );
        }),
      ],
    );
  }
}
