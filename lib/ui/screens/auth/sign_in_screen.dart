import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  static String name ="sign-in";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Sign In"),),
    );
  }
}
