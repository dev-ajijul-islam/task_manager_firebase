class MessageModel {
  String senderId;
  String text;
  DateTime createdAt;

  MessageModel({
    required this.senderId,
    required this.text,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'] ?? '',
      text: json['text'] ?? '',
      createdAt: (json['createdAt'] as DateTime),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'text': text,
      'createdAt': createdAt,
    };
  }
}
