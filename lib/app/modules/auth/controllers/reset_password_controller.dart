import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

class ResetPasswordController extends GetxController {
  final TextEditingController oldPasswordController = .new();
  final TextEditingController newPasswordController = .new();
  final TextEditingController confirmNewPasswordController = .new();

  RxBool isLoading = false.obs;

  Future<void> resetPassword() async {
    isLoading.value = true;
    try {
      final user = FirebaseServices.auth.currentUser;

      if (user == null || user.email == null) {
        Get.snackbar("Failed", "User not logged in");
        return;
      }

      final credential = EmailAuthProvider.credential(
        email: user.email.toString(),
        password: oldPasswordController.text,
      );

      await user.reauthenticateWithCredential(credential);

      user.updatePassword(newPasswordController.text);

      newPasswordController.clear();
      oldPasswordController.clear();
      confirmNewPasswordController.clear();
      Get.snackbar("Success", "Password reset Success");
    } on FirebaseException catch (e) {
      Get.snackbar("Failed", e.message.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
