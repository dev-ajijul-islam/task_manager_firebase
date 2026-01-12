class ConversationModel {
  String id;
  List<String> users;
  String lastMessage;
  DateTime createdAt;

  ConversationModel({
    required this.id,
    required this.users,
    required this.lastMessage,
    required this.createdAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json, String docId) {
    return ConversationModel(
      id: docId,
      users: List<String>.from(json['users'] ?? []),
      lastMessage: json['lastMessage'] ?? "",
      createdAt: (json['createdAt'] as DateTime),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'users': users,
      'lastMessage': lastMessage,
      'createdAt': createdAt,
    };
  }
}
