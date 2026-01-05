import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_firebase/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager_firebase/ui/screens/auth/sign_up_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static String name = "welcome-screen";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final List<Map<String, dynamic>> sliders = [
    {
      "title": "Stay organized. Get more done",
      "description":
          "Organize your workflow, prioritize with ease, and accomplish more every day.",
      "image": "assets/images/sliders/slider_1.png",
    },
    {
      "title": "Plan smarter. Work faster",
      "description":
          "Create clear plans, manage tasks efficiently, and boost your productivity.",
      "image": "assets/images/sliders/slider_2.png",
    },
    {
      "title": "Track progress effortlessly",
      "description":
          "Monitor your daily progress and stay motivated with simple tracking.",
      "image": "assets/images/sliders/slider_3.png",
    },
    {
      "title": "Focus on what matters",
      "description":
          "Eliminate distractions and focus on tasks that truly make an impact.",
      "image": "assets/images/sliders/slider_4.png",
    },
    {
      "title": "Achieve goals step by step",
      "description":
          "Break big goals into small steps and achieve them consistently.",
      "image": "assets/images/sliders/slider_5.png",
    },
  ];

  int currentSliderIndex = 0;

  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
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
                  items: sliders.map((s) => Image.asset(s["image"])).toList(),
                  options: CarouselOptions(
                    onPageChanged: (index, reason) => setState(() {
                      currentSliderIndex = index;
                    }),
                    enlargeCenterPage: true,
                    enlargeFactor: 0.40,
                    enlargeStrategy: .zoom,
                    viewportFraction: 0.70,
                    height: 400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    spacing: 5,
                    children: [
                      Text(
                        sliders[currentSliderIndex]["title"],
                        style: TextTheme.of(context).titleMedium?.copyWith(
                          fontWeight: .w700,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        sliders[currentSliderIndex]["description"],
                        textAlign: .center,
                        style: TextTheme.of(context).bodyMedium,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: .center,
                        children: List.generate(sliders.length, (index) {
                          final bool isActive = index == currentSliderIndex;
                          return InkWell(
                            onTap: () {
                              setState(() {
                                currentSliderIndex = index;
                                _carouselController.animateToPage(
                                  currentSliderIndex,
                                );
                              });
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
                        }),
                      ),
                    ],
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
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            SignUpScreen.name,
                            (route) => false,
                          );
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
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SignInScreen.name,
                  (route) => false,
                );
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
