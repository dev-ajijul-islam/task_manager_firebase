import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? id;
  Map<String, dynamic> createdBy;
  final bool isRecurring;
  final String title;
  final String description;
  final DateTime dueDate;
  final String priority;
  final String status;
  final List<String> tags;
  final String? frequency;
  final DateTime? endDate;
  final DateTime createdAt;
  final DateTime? updatedAt;

  TaskModel({
    this.id,
    this.updatedAt,
    required this.isRecurring,
    required this.createdBy,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.status,
    required this.tags,
    required this.frequency,
    required this.endDate,
    required this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json["id"],
      isRecurring: json["isRecurring"],
      createdAt: (json["createdAt"] as Timestamp).toDate(),
      createdBy: json["createdBy"],
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
      updatedAt: json["updatedAt"] != null
          ? (json["updatedAt"] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "isRecurring": isRecurring,
      "createdBy": createdBy,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
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
