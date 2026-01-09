import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/on_start/views/splash_screen.dart';
import 'package:task_manager_firebase/app/modules/on_start/views/welcome_screen.dart';
import 'package:task_manager_firebase/app/routes/app_routes.dart';
import 'package:task_manager_firebase/ui/main_layout.dart';

class PageRoutes {
  static final List<GetPage> routes = [
    GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
    GetPage(name: AppRoutes.welcomeScreen, page: () => WelcomeScreen()),
    GetPage(name: AppRoutes.mainLayout, page: () => MainLayout()),
  ];
}
