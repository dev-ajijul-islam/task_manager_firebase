import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 2),
      () => Get.toNamed(AppRoutes.welcomeScreen),
    );
    return Scaffold(
      backgroundColor: ColorScheme.of(context).secondary,
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Image.asset("assets/images/splash_logo.png", width: 170),
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
