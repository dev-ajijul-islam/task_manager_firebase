import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/chat/data/models/conversation_model.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';
import 'package:task_manager_firebase/app/modules/chat/data/models/message_model.dart';

class ChatController extends GetxController {
  RxList<ConversationModel> conversations = <ConversationModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to conversations where current user is a participant
    FirebaseServices.firestore
        .collection("conversations")
        .where("users", arrayContains: FirebaseServices.auth.currentUser?.uid)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .listen((snapshot) {
      conversations.value = snapshot.docs
          .map((doc) => ConversationModel.fromJson(doc.data(), doc.id))
          .toList();
      isLoading.value = false;
    }, onError: (e) {
      isLoading.value = false;
    });
  }

  /// Start a new conversation if not exists
  Future<ConversationModel> startConversation(String otherUserId) async {
    final currentUserId = FirebaseServices.auth.currentUser!.uid;

    // Check if conversation already exists
    final query = await FirebaseServices.firestore
        .collection("conversations")
        .where("users", arrayContains: currentUserId)
        .get();

    for (var doc in query.docs) {
      final users = List<String>.from(doc.data()["users"]);
      if (users.contains(otherUserId)) {
        // Conversation already exists
        return ConversationModel.fromJson(doc.data(), doc.id);
      }
    }

    // Create new conversation
    final docRef =
    await FirebaseServices.firestore.collection("conversations").add({
      "users": [currentUserId, otherUserId],
      "lastMessage": "",
      "createdAt": DateTime.now(),
    });

    return ConversationModel(
      id: docRef.id,
      users: [currentUserId, otherUserId],
      lastMessage: "",
      createdAt: DateTime.now(),
    );
  }
}
