import 'package:task_manager_firebase/app/modules/auth/data/models/user_model.dart';

class CommentModel {
  final UserModel user;
  final String taskId;
  final String comment;
  final DateTime commentedAt;

  CommentModel({
    required this.user,
    required this.comment,
    required this.commentedAt,
    required this.taskId,
  });

  factory CommentModel.fromJson(Map<dynamic, dynamic> json) {
    return CommentModel(
      user: UserModel.fromJson(json["user"]),
      comment: json["comment"],
      commentedAt: json["commentedAt"],
      taskId: json["taskId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user": user.toJson(),
      "comment": comment,
      "commentedAt": commentedAt,
      "taskId": taskId,
    };
  }
}
