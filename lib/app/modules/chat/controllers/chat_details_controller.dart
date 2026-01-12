import 'package:get/get.dart';
import 'package:task_manager_firebase/app/modules/chat/data/models/message_model.dart';
import 'package:task_manager_firebase/app/services/firebase_services.dart';

class ChatDetailsController extends GetxController {
  final String conversationId;

  ChatDetailsController({required this.conversationId});

  RxList<MessageModel> messages = <MessageModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to messages in this conversation
    FirebaseServices.firestore
        .collection("conversations")
        .doc(conversationId)
        .collection("messages")
        .orderBy("createdAt")
        .snapshots()
        .listen((snapshot) {
      messages.value =
          snapshot.docs.map((doc) => MessageModel.fromJson(doc.data())).toList();
      isLoading.value = false;
    }, onError: (e) {
      isLoading.value = false;
    });
  }

  /// Send a new text message
  Future<void> sendMessage(String text) async {
    final currentUserId = FirebaseServices.auth.currentUser!.uid;
    final timestamp = DateTime.now();

    final message = {
      "senderId": currentUserId,
      "text": text,
      "createdAt": timestamp,
    };

    await FirebaseServices.firestore
        .collection("conversations")
        .doc(conversationId)
        .collection("messages")
        .add(message);

    // Update last message in conversation
    await FirebaseServices.firestore
        .collection("conversations")
        .doc(conversationId)
        .update({
      "lastMessage": text,
      "createdAt": timestamp,
    });
  }
}
