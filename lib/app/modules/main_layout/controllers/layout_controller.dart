import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/calender/views/calender_screen.dart';
import 'package:task_manager_firebase/app/modules/chat/views/chat_screen.dart';
import 'package:task_manager_firebase/app/modules/home/views/home_screen.dart';
import 'package:task_manager_firebase/app/modules/profile/profile_screen.dart';

class LayoutController extends GetxController {
  final List<Widget> screens = [
    HomeScreen(),
    CalenderScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  var currentScreenIndex = 0.obs;
}
