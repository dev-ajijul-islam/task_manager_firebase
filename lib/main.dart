import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/routes/app_routes.dart';
import 'package:task_manager_firebase/app/routes/page_routes.dart';
import 'package:task_manager_firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  runApp(TaskManager());
}

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    Color primary = Color(0xFF3377FF);
    Color secondary = Color(0xFF2563EB);
    Color surface = Color(0xFFE3EDFF);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .light(
          primary: primary,
          secondary: secondary,
          surface: surface,
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
          hintStyle: .new(color: Colors.grey, fontSize: 14),
          contentPadding: .symmetric(horizontal: 15),
          fillColor: primary,
          focusedBorder: OutlineInputBorder(
            borderRadius: .circular(10),
            borderSide: BorderSide(color: primary),
          ),
          border: OutlineInputBorder(borderRadius: .circular(10)),
        ),
      ),
      initialRoute: AppRoutes.splashScreen,
      getPages: PageRoutes.routes,
    );
  }
}
