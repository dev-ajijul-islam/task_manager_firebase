import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/auth/views/reset_password_screen.dart';
import 'package:task_manager_firebase/app/modules/auth/views/sign_in_screen.dart';
import 'package:task_manager_firebase/app/modules/auth/views/sign_up_screen.dart';
import 'package:task_manager_firebase/app/modules/chat/views/chat_details.dart';
import 'package:task_manager_firebase/app/modules/on_start/views/splash_screen.dart';
import 'package:task_manager_firebase/app/modules/on_start/views/welcome_screen.dart';
import 'package:task_manager_firebase/app/modules/search_tasks/views/search_screen.dart';
import 'package:task_manager_firebase/app/routes/app_routes.dart';
import 'package:task_manager_firebase/app/modules/main_layout/views/main_layout.dart';

class PageRoutes {
  static final List<GetPage> routes = [
    GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
    GetPage(name: AppRoutes.welcomeScreen, page: () => WelcomeScreen()),
    GetPage(name: AppRoutes.mainLayout, page: () => MainLayout()),
    GetPage(name: AppRoutes.chatDetails, page: () => ChatDetailsScreen()),
    GetPage(name: AppRoutes.signInScreen, page: () => SignInScreen()),
    GetPage(name: AppRoutes.signUpScreen, page: () => SignUpScreen()),
    GetPage(name: AppRoutes.searchScreen, page: () => SearchScreen()),
    GetPage(
      name: AppRoutes.resetPasswordScreen,
      page: () => ResetPasswordScreen(),
    ),
  ];
}
