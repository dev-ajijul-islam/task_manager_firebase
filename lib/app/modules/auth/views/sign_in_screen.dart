import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_firebase/app/routes/app_routes.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();


  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  void _submit() {
    if (_formKey.currentState!.validate()) {


      final email = emailController.text.trim();
      final password = passwordController.text;
      debugPrint("Email: $email");
      debugPrint("Password: $password");
    }
  }

  @override
  void dispose() {

    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    "Welcome back, login to mnage your task effortlessly",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  Form(
                    key: _formKey,
                    child: Column(
                      spacing: 5,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Email"),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "Enter your email",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }
                            if (!value.contains('@')) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                        ),

                        const Text("Password"),
                        TextFormField(
                          controller: passwordController,
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

                        const SizedBox(height: 10),

                        FilledButton(
                          onPressed: _submit,
                          child: const Text("Sign In"),
                        ),

                        Row(
                          children: const [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text("or sign up with"),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),

                        const SizedBox(height: 10),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/google.png",
                                  height: 20,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Continue with Google",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        Align(
                          child: RichText(
                            text: TextSpan(
                              style:
                              const TextStyle(color: Colors.black54),
                              text: "Already have an account? ",
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                     Get.toNamed(AppRoutes.signUpScreen);
                                    },
                                  text: "Register",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary,
                                  ),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
