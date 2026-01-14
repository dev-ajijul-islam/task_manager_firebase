import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/auth/controllers/update_profile_controller.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({super.key});

  final UpdateProfileController updateProfileController = Get.put(
    UpdateProfileController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  spacing: 10,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    Text(
                      "Update Profile",
                      style: TextTheme.of(context).titleLarge,
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Center(
                  child: Form(
                    child: Column(
                      spacing: 10,
                      children: [
                        Stack(
                          alignment: .center,
                          clipBehavior: .none,
                          children: [
                            Obx(
                              () => CircleAvatar(
                                radius: 70,
                                backgroundImage:
                                    updateProfileController
                                            .profilePhotoFile
                                            ?.value !=
                                        null
                                    ? FileImage(
                                        File(
                                          updateProfileController
                                              .profilePhotoFile
                                              .value!
                                              .path,
                                        ),
                                      )
                                    : NetworkImage(
                                        updateProfileController.photoURL
                                            .toString(),
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: -20,
                              child: FloatingActionButton(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                                  borderRadius: .circular(100),
                                ),
                                onPressed: () {
                                  updateProfileController.pickImage();
                                },
                                child: Icon(Icons.add_circle_outline),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        TextField(
                          enabled: false,
                          controller: updateProfileController.emailTEController,
                          decoration: .new(hintText: "Enter email"),
                        ),
                        TextField(
                          controller: updateProfileController.nameTEController,
                          decoration: .new(hintText: "Enter name"),
                        ),
                        SizedBox(height: 30),
                        Obx(
                          () => FilledButton(
                            onPressed: updateProfileController.isLoading.value
                                ? null
                                : updateProfileController.updateProfile,
                            child: updateProfileController.isLoading.value
                                ? Center(
                                    child: SizedBox(
                                      width: 15,
                                      height: 15,
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : Text("Update Profile"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
