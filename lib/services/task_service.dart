import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task.dart';
import '../models/user.dart';
import '../utils/constants.dart';

abstract class TaskService {
  Future<void> addTaskToDB(TaskModel taskModel) async {
    try {
      await firestore.collection("tasks").doc(taskModel.taskId).set({
        'taskId': taskModel.taskId,
        'classId': taskModel.classId,
        'className': taskModel.className,
        'description': taskModel.description,
        'finalDate': taskModel.finalDate,
        'isDone': taskModel.isDone
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<TaskModel>> getTaskStreamFromDB() {
    return firestore
        .collection("tasks")
        .orderBy("finalDate")
        .snapshots()
        .map((QuerySnapshot query) {
      List<TaskModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(TaskModel.fromSnap(element));
      }
      return retVal;
    });
  }

  Stream<List<TaskModel>> getTaskStreamByClassFrmDB(String classId) {
    return firestore
        .collection("tasks")
        .where('classId', isEqualTo: classId)
        .orderBy("finalDate")
        .snapshots()
        .map((QuerySnapshot query) {
      List<TaskModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(TaskModel.fromSnap(element));
      }
      return retVal;
    });
  }

  Stream<List<TaskModel>> getTaskStreamByClassFromUserFromDB(UserModel? user) {
    return firestore.collection("tasks").snapshots().map((QuerySnapshot query) {
      List<TaskModel> retVal = [];
      for (var element in query.docs) {
        var taskModel = (TaskModel.fromSnap(element));
        var classId = (TaskModel.fromSnap(element)).classId;
        for (var f in user!.classes) {
          if (f == classId) {
            retVal.add(taskModel);
          }
        }
      }
      retVal.sort((a, b) => a.finalDate.compareTo(b.finalDate));
      return retVal;
    });
  }

  Future<void> deleteTaskFromDB(String taskId) async {
    try {
      await firestore.collection('tasks').doc(taskId).delete();
    } catch (err) {
      rethrow;
    }
  }
}
