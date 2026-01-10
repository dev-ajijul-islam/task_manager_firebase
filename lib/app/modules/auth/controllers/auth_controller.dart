import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/data/services/firebase_services.dart';
import 'package:task_manager_firebase/app/routes/app_routes.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  String? idToken;
  User? user;

  @override
  void onInit() {
    _watchUser();
    super.onInit();
  }

  ///-------------------------- sign in -------------------------------
  Future<void> login({required String email, required String password}) async {
    isLoading.value = true;
    try {
      await FirebaseServices.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offAndToNamed(AppRoutes.mainLayout);
    } on FirebaseException catch (e) {
      Get.snackbar("Login Failed", e.message.toString());
    } finally {
      isLoading.value = false;
    }
  }

  ///-----------------------------sign up --------------------------------
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      await FirebaseServices.auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((credentials) => credentials.user?.updateDisplayName(name));
      Get.toNamed(AppRoutes.signInScreen);
      Get.snackbar("Success", "sign up success");
    } on FirebaseException catch (e) {
      Get.snackbar("Sign up failed", e.message.toString());
    } finally {
      isLoading.value = false;
    }
  }

  ///----------------------------watch currentUser -----------------------
  Future<void> _watchUser() async {
    FirebaseServices.auth.authStateChanges().listen((user) async {
      user = user;
      final Future<String?> token = user!.getIdToken();
      idToken = await token;
    });
  }
}
