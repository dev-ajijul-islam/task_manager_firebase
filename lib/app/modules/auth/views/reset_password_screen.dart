import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/auth/controllers/reset_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ResetPasswordController resetPasswordController = Get.put(
    ResetPasswordController(),
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
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back_ios_new_outlined),
                    ),
                    Text(
                      "Reset Password",
                      style: TextTheme.of(context).titleLarge,
                    ),
                  ],
                ),
                Center(
                  child: Column(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      Text(
                        "Reset Password",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        "Reset password by confirming old password, login to manage your task effortlessly",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      Form(
                        key: _formKey,
                        child: Column(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Old Password"),
                            TextFormField(
                              controller:
                                  resetPasswordController.oldPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: "Enter your password",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password is required";
                                }
                                if (value.length < 6) {
                                  return "Minimum 6 characters";
                                }
                                return null;
                              },
                            ),
                            const Text("New Password"),
                            TextFormField(
                              controller:
                                  resetPasswordController.newPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: "Enter your password",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password is required";
                                }
                                if (value.length < 6) {
                                  return "Minimum 6 characters";
                                }
                                return null;
                              },
                            ),
                            const Text("Confirm New Password"),
                            TextFormField(
                              controller: resetPasswordController
                                  .confirmNewPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: "Enter your password",
                              ),
                              validator: (value) {
                                if (resetPasswordController
                                        .newPasswordController
                                        .text !=
                                    value) {
                                  return "Password is not matched";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 10),

                            Obx(() {
                              return FilledButton(
                                onPressed:
                                    resetPasswordController.isLoading.value
                                    ? null
                                    : _submit,
                                child:
                                    resetPasswordController.isLoading.value ==
                                        true
                                    ? SizedBox(
                                        width: 15,
                                        height: 15,
                                        child: CircularProgressIndicator(),
                                      )
                                    : Text("Reset Password"),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      resetPasswordController.resetPassword();
    }
  }
}
