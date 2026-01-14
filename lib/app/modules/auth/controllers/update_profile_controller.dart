import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_firebase/app/modules/auth/controllers/auth_controller.dart';
import 'package:task_manager_firebase/app/routes/app_routes.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';
import 'package:http/http.dart' as http;

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  final TextEditingController nameTEController = TextEditingController();
  final TextEditingController emailTEController = TextEditingController();
  final RxString photoURL =
      (FirebaseServices.auth.currentUser?.photoURL ?? '').obs;

  final Rxn<XFile> profilePhotoFile = Rxn<XFile>();

  final AuthController authController = Get.put(AuthController());

  @override
  void onInit() {
    nameTEController.text = FirebaseServices.auth.currentUser!.displayName!
        .toString();
    emailTEController.text = FirebaseServices.auth.currentUser!.email
        .toString();

    super.onInit();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = .new();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    profilePhotoFile?.value = picked;
  }

  Future<void> updateProfile() async {
    isLoading.value = true;

    try {
      final user = FirebaseServices.auth.currentUser;
      Map<String, dynamic> data = {};

      if (profilePhotoFile.value != null) {
        final imageByte = await File(
          profilePhotoFile.value!.path,
        ).readAsBytes();
        final imageBbResponse = await http.post(
          Uri.parse(
            "https://api.imgbb.com/1/upload?key=5350a71f27b5f7f75e8d222f343c8cd4",
          ),
          body: {"image": base64Encode(imageByte)},
        );

        if (imageBbResponse.statusCode == 200) {
          final decodedData = jsonDecode(imageBbResponse.body);
          data["photoURL"] = decodedData["data"]["url"];
        }
      }

      if (nameTEController.text.isNotEmpty) {
        data["displayName"] = nameTEController.text.trim();
      }

      await user?.updateProfile(
        photoURL: data["photoURL"],
        displayName: data["displayName"],
      );

      user?.reload();
      profilePhotoFile.value = null;
      Get.toNamed(AppRoutes.mainLayout);
      Get.snackbar("Success", "Profile updated");
    } on FirebaseException catch (e) {
      Get.snackbar("Filed", e.message.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
