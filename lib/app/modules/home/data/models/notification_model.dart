import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String? title;
  final String? text;
  final DateTime createdAt;
  final String userId;

  NotificationModel({
    required this.title,
    required this.text,
    required this.createdAt,
    required this.userId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json["title"],
      text: json["text"],
      createdAt: (["createdAt"] as Timestamp).toDate(),
      userId: json["userId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "text": text,
      "createdAt": createdAt,
      "userId": userId,
    };
  }
}
