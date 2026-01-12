import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager_firebase/app/modules/auth/data/models/user_model.dart';

class ConversationModel {
  final String id;

  final List<String> userIds;

  final Map<String, UserModel> usersMap;

  final String lastMessage;
  final DateTime createdAt;

  ConversationModel({
    required this.id,
    required this.userIds,
    required this.usersMap,
    required this.lastMessage,
    required this.createdAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json, String docId) {
    return ConversationModel(
      id: docId,
      userIds: List<String>.from(json['userIds'] ?? []),
      usersMap: (json['usersMap'] as Map<String, dynamic>).map(
        (key, value) =>
            MapEntry(key, UserModel.fromJson(Map<String, dynamic>.from(value))),
      ),
      lastMessage: json['lastMessage'] ?? "",
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userIds": userIds,
      "usersMap": usersMap.map((key, value) => MapEntry(key, value.toJson())),
      "lastMessage": lastMessage,
      "createdAt": createdAt,
    };
  }

  UserModel getOtherUser(String currentUid) {
    return usersMap.values.firstWhere((u) => u.uid != currentUid);
  }
}
