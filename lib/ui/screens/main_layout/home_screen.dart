import 'package:avatar_stack/animated_avatar_stack.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorScheme.of(context).onPrimary,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text("Categories", style: TextTheme.of(context).titleLarge),
                  TextButton(onPressed: () {}, child: Text("See All")),
                ],
              ),
            ),
            CarouselSlider(
              items: [
                Container(
                  clipBehavior: .hardEdge,
                  margin: .all(10),
                  width: .infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: .circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: .infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ColorScheme.of(context).primary,
                                Colors.purpleAccent.shade100,
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Column(
                              mainAxisAlignment: .center,
                              crossAxisAlignment: .start,
                              children: [
                                Text(
                                  "Web design",
                                  style: TextTheme.of(
                                    context,
                                  ).titleLarge?.copyWith(color: Colors.white),
                                ),
                                Text(
                                  "5 Projects",
                                  style: TextTheme.of(
                                    context,
                                  ).titleMedium?.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: .only(left: 16,right: 5,bottom: 5),
                          child: Column(
                            mainAxisAlignment: .end,
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                "60%",
                                style: TextTheme.of(
                                  context,
                                ).bodyLarge?.copyWith(fontSize: 17),
                              ),
                              Row(
                                spacing: 5,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: LinearProgressBar(
                                      maxSteps: 100,
                                      progressType: ProgressType.linear,
                                      currentStep: 60,
                                      progressColor: ColorScheme.of(context).primary,
                                      backgroundColor: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(10),
                                      minHeight: 5,
                                    ),
                                  ),
                                  Expanded(
                                    child: AnimatedAvatarStack(
                                      borderColor: Colors.white,
                                      height: 30,
                                      avatars: [
                                        for (var n = 0; n < 5; n++)
                                          NetworkImage(
                                            'https://i.pravatar.cc/150?img=$n',
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              options: CarouselOptions(
                aspectRatio: 2.4,
                viewportFraction: 0.55,
                disableCenter: true,
                pageSnapping: false,
                enableInfiniteScroll: false,
                padEnds: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
