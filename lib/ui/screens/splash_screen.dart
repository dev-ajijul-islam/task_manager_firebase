import 'package:flutter/material.dart';
import 'package:task_manager_firebase/ui/main_layout.dart';
import 'package:task_manager_firebase/ui/screens/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 2),
          () => Navigator.pushNamedAndRemoveUntil(
        context,
        MainLayout.name,
            (route) => false,
      ),
    );
    return Scaffold(
      backgroundColor: ColorScheme.of(context).secondary,
      body: Center(
        child: Image.asset("assets/images/splash_logo.png", width: 170),
      ),
    );
  }
}
