import 'package:task_manager_firebase/app/data/provider/auth_provider.dart';

class AuthRepository {
  final AuthProvider provider;

  AuthRepository({required this.provider});

  Future<void> login({required String email, required String password}) async {
    provider.login(email: email, password: password);
  }
}
