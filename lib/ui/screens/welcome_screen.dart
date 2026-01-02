import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static String name = "welcome-screen";

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
                SizedBox(height: 70),
                CarouselSlider(
                  items: [
                    Column(
                      children: [
                        Image.asset("assets/images/sliders/slider_1.png"),
                      ],
                    ),
                  ],
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    enlargeFactor: 0.40,
                    enlargeStrategy: .zoom,
                    viewportFraction: 0.70,
                    height: 400,
                  ),
                ),
                Column(
                  spacing: 5,
                  children: [
                    Text(
                      "Stay organized. Get more done",
                      style: TextTheme.of(
                        context,
                      ).titleMedium?.copyWith(fontWeight: .w700, fontSize: 20),
                    ),
                    Text(
                      "Organize your workflow. prioritize with ease. and accomplish more everyday",
                      textAlign: .center,
                      style: TextTheme.of(context).bodyMedium,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    spacing: 10,
                    children: [
                      FilledButton(onPressed: () {}, child: Text("Sign in")),
                      OutlinedButton(onPressed: () {}, child: Text("Sign Up")),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            top: 50,
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Skip",
                style: TextStyle(color: ColorScheme.of(context).onPrimary),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 + 230,
            child: Row(
              spacing: 8,
              mainAxisAlignment: .center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: ColorScheme.of(context).onSecondary,
                    borderRadius: .circular(100),
                  ),
                ),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: ColorScheme.of(context).onSecondary,
                    borderRadius: .circular(100),
                  ),
                ),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: ColorScheme.of(context).onSecondary,
                    borderRadius: .circular(100),
                  ),
                ),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: ColorScheme.of(context).onSecondary,
                    borderRadius: .circular(100),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
