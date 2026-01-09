import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/on_start/controllers/welcome_slider_controller.dart';
import 'package:task_manager_firebase/app/routes/app_routes.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final WelcomeSliderController sliderController = Get.put(
    WelcomeSliderController(),
  );

  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    var currentSliderIndex = sliderController.currentSliderIndex;
    return Scaffold(
      body: Stack(
        alignment: .bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ColorScheme.of(context).secondary,
                  ColorScheme.of(context).surface,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: .spaceBetween,
              children: [
                SizedBox(height: 90),
                CarouselSlider(
                  carouselController: _carouselController,
                  items: sliderController.sliders
                      .map((s) => Image.asset(s["image"]))
                      .toList(),
                  options: CarouselOptions(
                    onPageChanged: (index, reason) => currentSliderIndex(index),

                    enlargeCenterPage: true,
                    enlargeFactor: 0.40,
                    enlargeStrategy: .zoom,
                    viewportFraction: 0.70,
                    height: 400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Obx(
                    () => Column(
                      spacing: 5,
                      children: [
                        Text(
                          sliderController
                              .sliders[currentSliderIndex()]["title"],
                          style: TextTheme.of(context).titleMedium?.copyWith(
                            fontWeight: .w700,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          sliderController
                              .sliders[currentSliderIndex()]["description"],
                          textAlign: .center,
                          style: TextTheme.of(context).bodyMedium,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: .center,
                          children: List.generate(
                            sliderController.sliders.length,
                            (index) {
                              final bool isActive =
                                  index == currentSliderIndex();
                              return InkWell(
                                onTap: () {
                                  currentSliderIndex(index);
                                  _carouselController.animateToPage(
                                    currentSliderIndex(index),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: isActive
                                          ? ColorScheme.of(context).onSecondary
                                          : ColorScheme.of(context).onPrimary,
                                      borderRadius: .circular(100),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    spacing: 10,
                    children: [
                      FilledButton(onPressed: () {}, child: Text("Sign in")),
                      OutlinedButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.mainLayout);
                        },
                        child: Text("Sign Up"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            top: 40,
            child: TextButton(
              onPressed: () {
                Get.toNamed(AppRoutes.mainLayout);
              },
              child: Text(
                "Skip",
                style: TextStyle(color: ColorScheme.of(context).onPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
