import 'package:flutter/material.dart';
import 'package:pronerd/controller/date_picker_controller.dart';
import 'package:pronerd/controller/drop_down_controller.dart';
import 'package:pronerd/controller/post_controller.dart';
import 'package:pronerd/models/task.dart';
import 'package:pronerd/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../components/build_snack_bar.dart';
import '../models/room.dart';
import 'auth_controller.dart';
import 'class_controller.dart';

class TaskController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: '_screenkey');
  DateController dateController = Get.put(DateController());
  DropDownController dropdownController = Get.put(DropDownController());
  ClassController classController = Get.put(ClassController());
  AuthController auth = Get.find();
  PostController postController = Get.put(PostController());


  @override
  void onInit() {
    super.onInit();
    taskList.bindStream(taskStream()); //stream coming from firebase
  }

  @override
  void onReady() {
    _taskListByClassFromUser.bindStream(taskStreamByClassFromUserT());
  }

  Future<void> onClick(String snap) async {
    taskListByClass
        .bindStream(taskStreamByClass(snap)); //stream coming from firebase
  }

  Future<void> onFollow() async {
    _taskListByClassFromUser.bindStream(taskStreamByClassFromUserT());

  }

  Rx<List<TaskModel>> taskList = Rx<List<TaskModel>>([]);
  Rx<List<TaskModel>> taskListByClass = Rx<List<TaskModel>>([]);
  final Rx<List<TaskModel>> _taskListByClassFromUser = Rx<List<TaskModel>>([]);


  final Rx<List<TaskModel>> filteredTaskList = Rx<List<TaskModel>>([]);
  final Rx<List<TaskModel>> taskListNew = Rx<List<TaskModel>>([]);


  List<TaskModel> get taskListByClassFromUser => _taskListByClassFromUser.value;

  final RxString _classId = "".obs;
  final RxString _className = "".obs;
  final RxString _description = "".obs;
  final RxBool _isDone = false.obs;

  String get className => _className.value;

  String get classId => _classId.value;

  setClassId(String value) => _classId.value = value;

  setClassName(String value) => _className.value = value;

  setDescription(String value) => _description.value = value;

  setIsDone(bool value) => _isDone.value = value;

  getIsDone() => _isDone.value;

  set(v, v1) {
    _className.value = v;
    _classId.value = v1;
  }

  Future<void> addTask() async {
    try {
      String taskId = const Uuid().v1();
      await firestore.collection("tasks").doc(taskId).set({
        'taskId': taskId,
        'classId': _classId.value,
        'className': _className.value,
        'description': _description.value,
        'finalDate': dateController.pickedDate!.value,
        'isDone': _isDone.value
      });
      reset();
      updateList();
      //formKey.currentState!.reset();
    } catch (e) {
      //rethrow;
    }
  }

  Stream<List<TaskModel>> taskStream() {
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

  Stream<List<TaskModel>> taskStreamByClass(String classId) {
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

  Stream<List<TaskModel>> taskStreamByClassFromUser() {
    return firestore
        .collection("rooms")
        .where("followers", arrayContains: auth.user.uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<TaskModel> retVal = [];
      for (var element in query.docs) {
        var classId = (RoomModel.fromSnap(element)).classId;
        var el = taskList.value
            .where((e) => e.classId == classId)
            .first;
        retVal.add(el);
      }
      return retVal;
    });
  }

  Stream<List<TaskModel>> taskStreamByClassFromUserT() {
    return firestore
        .collection("tasks")
        .snapshots()
        .map((QuerySnapshot query) {
      List<TaskModel> retVal = [];
      for (var element in query.docs) {
        var taskModel = (TaskModel.fromSnap(element));
        var classId = (TaskModel.fromSnap(element)).classId;
        for (var f in classController.classListByUserT) {
          if (f.classId == classId) {
            retVal.add(taskModel);
          }
        }
      }
      retVal.sort((a, b) => a.finalDate.compareTo(b.finalDate));
      return retVal;
    });
  }

  void reset() {
    setDescription('');
    // setClassId('');
  }

  Future<void> deleteTask(String taskId) async {
    String res = "Some error occurred";
    try {
      await firestore.collection('tasks').doc(taskId).delete();
      res = 'Entrega concluída com sucesso';
      updateList();
      return CustomSnack().buildCardSuccess(res.toString());
    } catch (err) {
      //return CustomSnack().buildCardError(res.toString());
    }
  }

  Future updateHome() async {
    postController.onFollow();
    onFollow();
  }

  updateList()  {
    filteredTaskList.value = taskListByClassFromUser;
  }

  void runFilter(String enteredKeyword) {
    List<TaskModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = taskListByClassFromUser;
    } else {
      results = taskListByClassFromUser
          .where((task) =>
          task.description
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    filteredTaskList.value = results;
  }

}
