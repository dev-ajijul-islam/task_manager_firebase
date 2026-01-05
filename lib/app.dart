import 'package:flutter/material.dart';
import 'package:task_manager_firebase/ui/main_layout.dart';
import 'package:task_manager_firebase/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager_firebase/ui/screens/auth/sign_up_screen.dart';
import 'package:task_manager_firebase/ui/screens/splash_screen.dart';
import 'package:task_manager_firebase/ui/screens/welcome_screen.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    Color primary = Color(0xFF3377FF);
    Color secondary = Color(0xFF2563EB);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .light(
          primary: primary,
          secondary: secondary,
          surface: Color(0xFFE3EDFF),
          onSurface: Color(0xFF3A3A3C),
          onPrimary: Color(0xFFF2F2F5),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            minimumSize: .resolveWith(
              (states) => Size(MediaQuery.of(context).size.width, 50),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: .circular(10)),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            minimumSize: .resolveWith(
              (states) => Size(MediaQuery.of(context).size.width, 50),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: .circular(10)),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white12),
            side: WidgetStatePropertyAll(BorderSide(color: secondary)),
            minimumSize: .resolveWith(
              (states) => Size(MediaQuery.of(context).size.width, 50),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: .circular(10)),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: .new(
            color: Colors.grey,
            fontSize: 14
          ),
          contentPadding: .symmetric(horizontal: 15),
          fillColor: primary,
          focusedBorder: OutlineInputBorder(
            borderRadius: .circular(10),
            borderSide: BorderSide(color: primary),
          ),
          border: OutlineInputBorder(borderRadius: .circular(10)),
        ),
      ),
      routes: {
        WelcomeScreen.name: (_) => WelcomeScreen(),
        SignUpScreen.name: (_) => SignUpScreen(),
        SignInScreen.name: (_) => SignInScreen(),
        MainLayout.name : (_) => MainLayout()
      },
      home: SplashScreen(),
    );
  }
}
