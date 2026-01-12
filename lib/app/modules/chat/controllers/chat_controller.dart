import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/auth/data/models/user_model.dart';
import 'package:task_manager_firebase/app/modules/chat/data/models/conversation_model.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

class ChatController extends GetxController {
  RxList<ConversationModel> conversations = <ConversationModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();

    final currentUserId = FirebaseServices.auth.currentUser!.uid;

    FirebaseServices.firestore
        .collection("conversations")
        .where("userIds", arrayContains: currentUserId)
        .snapshots()
        .listen((snapshot) {
          conversations.value = snapshot.docs
              .map((doc) => ConversationModel.fromJson(doc.data(), doc.id))
              .toList();
          isLoading.value = false;
        });
  }

  Future<ConversationModel> startConversation(UserModel otherUser) async {
    final currentUser = FirebaseServices.auth.currentUser!;
    final currentUserId = currentUser.uid;

    // 🔍 Check if conversation already exists
    final query = await FirebaseServices.firestore
        .collection("conversations")
        .where("userIds", arrayContains: currentUserId)
        .get();

    for (final doc in query.docs) {
      final users = List<String>.from(doc.data()['userIds']);
      if (users.contains(otherUser.uid)) {
        return ConversationModel.fromJson(doc.data(), doc.id);
      }
    }

    // ➕ Create new conversation
    final Map<String, dynamic> usersMaps = {
      currentUserId: {
        "uid": currentUserId,
        "displayName": currentUser.displayName,
        "email": currentUser.email,
        "photoURL": currentUser.photoURL,
      },
      otherUser.uid: otherUser.toJson(),
    };

    final docRef = await FirebaseServices.firestore
        .collection("conversations")
        .add({
          "userIds": [currentUserId, otherUser.uid],
          "usersMap": usersMaps,
          "lastMessage": "",
          "createdAt": DateTime.now(),
        });

    return ConversationModel(
      id: docRef.id,
      userIds: [currentUserId, otherUser.uid],
      usersMap: {
        currentUserId: UserModel(
          uid: currentUserId,
          displayName: currentUser.displayName ?? '',
          email: currentUser.email ?? '',
          photoURL: currentUser.photoURL ?? '',
        ),
        otherUser.uid: otherUser,
      },
      lastMessage: "",
      createdAt: DateTime.now(),
    );
  }
}
