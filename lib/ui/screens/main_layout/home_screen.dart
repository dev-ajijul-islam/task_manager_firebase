import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
                  margin: .all(10),
                  width: .infinity,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: .circular(10),
                  ),
                  child: Column(children: []),
                ),
              ],
              options: CarouselOptions(
                aspectRatio: 2.5,
                viewportFraction: 0.6,
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
