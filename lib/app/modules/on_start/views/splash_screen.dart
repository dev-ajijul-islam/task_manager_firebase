import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/data/services/firebase_services.dart';
import 'package:task_manager_firebase/app/modules/auth/controllers/auth_controller.dart';
import 'package:task_manager_firebase/app/routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseServices.auth.authStateChanges(),
      builder: (context, snapshot) {
        Future.delayed(Duration(seconds: 2), () {
          if (snapshot.data != null) {
            Get.offAndToNamed(AppRoutes.mainLayout);
          } else {
            Get.offAndToNamed(AppRoutes.welcomeScreen);
          }
        });
        return Scaffold(
          backgroundColor: ColorScheme.of(context).secondary,
          body: Center(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Image.asset("assets/images/splash_logo.png", width: 170),
                SizedBox(
                  width: 110,
                  child: LinearProgressIndicator(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
