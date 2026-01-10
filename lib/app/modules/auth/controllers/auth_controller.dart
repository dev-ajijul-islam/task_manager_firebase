import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/data/services/firebase_services.dart';
import 'package:task_manager_firebase/app/routes/app_routes.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  Future<void> login({required String email, required String password}) async {
    isLoading.value = true;
    try {
      await FirebaseServices.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offAndToNamed(AppRoutes.mainLayout);
    } on FirebaseException catch (e) {
      Get.snackbar("Login Failed", "$e");
    } finally {
      isLoading.value = false;
    }
  }
}
