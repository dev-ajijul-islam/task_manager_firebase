import 'package:flutter/material.dart';
import 'package:task_manager_firebase/ui/screens/splash_screen.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    Color primary = Color(0xFF3377FF);
    Color secondary = Color(0xFF2563EB);
    return MaterialApp(
      theme: ThemeData(
        colorScheme: .light(
          primary: primary,
          secondary: secondary,
          surface: Color(0xFFE3EDFF),
          onSurface: Color(0xFF3A3A3C),
          onPrimary: Color(0xFFF2F2F5),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
