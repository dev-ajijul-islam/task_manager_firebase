import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/auth/controllers/auth_controller.dart';
import 'package:task_manager_firebase/app/routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    Future.delayed(Duration(seconds: 3),()async {
      if(authController.idToken != null){
        Get.offNamedUntil(AppRoutes.mainLayout, (route) => false,);
      }else{
        Get.offNamedUntil(AppRoutes.signInScreen, (route) => false,);
      }
    },);
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
  }
}
