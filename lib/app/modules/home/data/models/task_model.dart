class TaskModel {
  String? id;
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
      title: json["title"],
      description: json["description"],
      dueDate: json["dueDate"],
      priority: json["priority"],
      status: json["status"],
      tags: json["tags"],
      frequency: json["frequency"],
      endDate: json["endDate"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "dueDate": dueDate,
      "priority": priority,
      "status": status,
      "tags": tags,
      "frequency": frequency,
      "endDate": endDate,
    };
  }
}
