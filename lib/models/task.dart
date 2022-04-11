import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String taskId;
  final String classId;
  final String className;
  final String description;
  final DateTime finalDate;
  bool isDone;

  TaskModel({
    required this.taskId,
    required this.classId,
    required this.className,
    required this.description,
    required this.finalDate,
    this.isDone = false
  });


  static TaskModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return TaskModel(
        classId: snapshot["classId"],
        className: snapshot["className"],
        taskId: snapshot["taskId"],
      description: snapshot["description"],
        finalDate: snapshot["finalDate"].toDate(),
      isDone: snapshot['isDone']
    );
  }

  Map<String, dynamic> toJson() => {
    "classId": classId,
    "className": className,
        "taskId": taskId,
        "description": description,
        "finalDate": finalDate,
        "isDone": isDone
      };
}


