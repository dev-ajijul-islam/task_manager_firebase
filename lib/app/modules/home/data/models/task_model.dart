import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? id;
  String userId;
  final String title;
  final String description;
  final DateTime dueDate;
  final String priority;
  final String status;
  final List<String> tags;
  final String? frequency;
  final DateTime? endDate;

  TaskModel({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.status,
    required this.tags,
    required this.frequency,
    required this.endDate,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json["uid"],
      userId: json["userId"],
      title: json["title"],
      description: json["description"],
      dueDate: (json["dueDate"] as Timestamp).toDate(),
      priority: json["priority"],
      status: json["status"],
      tags: List<String>.from(json["tags"]),
      frequency: json["frequency"],
      endDate: json["endDate"] != null
          ? (json["endDate"] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "title": title,
      "description": description,
      "dueDate": Timestamp.fromDate(dueDate),
      "priority": priority,
      "status": status,
      "tags": tags,
      "frequency": frequency,
      "endDate": endDate != null ? Timestamp.fromDate(endDate!) : null,
    };
  }
}
