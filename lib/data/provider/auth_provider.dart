import 'package:task_manager_firebase/app/core/services/firebase_services.dart';

class AuthProvider {
  Future<void> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    await FirebaseServices.auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
