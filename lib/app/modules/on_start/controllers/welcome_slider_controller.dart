import 'package:get/get.dart';

class WelcomeSliderController extends GetxController{
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
  var currentSliderIndex = 0.obs;


}