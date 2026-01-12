import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_manager_firebase/app/modules/auth/data/models/user_model.dart';
import 'package:task_manager_firebase/app/routes/app_routes.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  String? idToken;
  User? user;

  @override
  void onInit() async {
    watchUser();
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

      final user = FirebaseServices.auth.currentUser!;

      final UserModel userModel = UserModel(
        uid: user.uid,
        displayName: user.displayName ?? "",
        email: user.email ?? "",
        photoURL: user.photoURL ?? "",
      );

      await saveUserIfNotExists(userModel);

      Get.toNamed(AppRoutes.signInScreen);
      Get.snackbar("Success", "Sign up success");
    } on FirebaseException catch (e) {
      Get.snackbar("Sign up failed", e.message.toString());
    } finally {
      isLoading.value = false;
    }
  }

  ///================================= Google Sign In ===========================
  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        throw Exception("Google ID Token is null");
      }

      final credential = GoogleAuthProvider.credential(idToken: idToken);

      final userCredential = await FirebaseServices.auth.signInWithCredential(
        credential,
      );

      if (userCredential.user == null) return;

      final user = FirebaseServices.auth.currentUser!;

      final UserModel userModel = UserModel(
        uid: user.uid,
        displayName: user.displayName ?? "",
        email: user.email ?? "",
        photoURL: user.photoURL ?? "",
      );

      await saveUserIfNotExists(userModel);

      Get.snackbar("Success", "Sign in success");
      Get.offNamedUntil(AppRoutes.mainLayout, (route) => false);
    } on FirebaseException catch (e) {
      Get.snackbar("Failed", e.message.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// ----------------------------sign out ------------------------------
  Future<void> signOut() async {
    await FirebaseServices.auth.signOut();
    Get.offNamedUntil(AppRoutes.signInScreen, (route) => false);
  }

  ///----------------------------watch currentUser -----------------------
  Future<void> watchUser() async {
    FirebaseServices.auth.authStateChanges().listen((user) async {
      if (user != null) {
        user = user;
        final Future<String?> token = user.getIdToken();
        idToken = await token;
      }
    });
  }

  //----------------- helper function for duplicate user check----------------
  Future<void> saveUserIfNotExists(UserModel userModel) async {
    final docRef = FirebaseServices.firestore
        .collection("users")
        .doc(userModel.uid);

    final docSnap = await docRef.get();

    if (!docSnap.exists) {
      await docRef.set(userModel.toJson());
    }
  }
}
