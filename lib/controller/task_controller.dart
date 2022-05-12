import 'package:pronerd/controller/date_picker_controller.dart';
import 'package:pronerd/controller/post_controller.dart';
import 'package:pronerd/controller/user_controller.dart';
import 'package:pronerd/models/task.dart';
import 'package:pronerd/services/task_service.dart';
import 'package:pronerd/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../components/build_snack_bar.dart';
import 'class_controller.dart';

class TaskController extends GetxController with TaskService {
  DateController dateController = Get.put(DateController());
  UserController userController = Get.find();

  @override
  void onInit() {
    super.onInit();
    taskList.bindStream(taskStream()); //stream coming from firebase
  }

  @override
  void onReady() {
    taskListByClassFromUser.bindStream(getTaskStreamByClassFromUser());
  }

  Future<void> onClick(String snap) async {
    taskListByClass
        .bindStream(taskStreamByClass(snap)); //stream coming from firebase
  }

  Future<void> onFollow() async {
    taskListByClassFromUser.bindStream(getTaskStreamByClassFromUser());
  }

  Rx<List<TaskModel>> taskList = Rx<List<TaskModel>>([]);
  Rx<List<TaskModel>> taskListByClass = Rx<List<TaskModel>>([]);
  final Rx<List<TaskModel>> taskListByClassFromUser = Rx<List<TaskModel>>([]);

  final Rx<List<TaskModel>> filteredTaskList = Rx<List<TaskModel>>([]);
  final Rx<List<TaskModel>> taskListNew = Rx<List<TaskModel>>([]);

  List<TaskModel> get getTaskListByClassFromUser =>
      taskListByClassFromUser.value;

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
      TaskModel taskModel = TaskModel(
          taskId: taskId,
          classId: _classId.value,
          className: _className.value,
          description: _description.value,
          finalDate: dateController.pickedDate!.value,
          isDone: _isDone.value);
      addTaskToDB(taskModel);
      resetDescriptionInput();
      resetTaskScreenList();
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<TaskModel>> taskStream() {
    try {
      return getTaskStreamFromDB();
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<TaskModel>> taskStreamByClass(String classId) {
    try {
      return getTaskStreamByClassFrmDB(classId);
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<TaskModel>> getTaskStreamByClassFromUser() {
    try {
      return getTaskStreamByClassFromUserFromDB(userController.userModel);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      deleteTaskFromDB(taskId);
      return CustomSnack().buildCardSuccess('Entrega concluída com sucesso');
    } catch (e) {
      rethrow;
    }
  }

  resetTaskScreenList() {
    filteredTaskList.value = getTaskListByClassFromUser;
  }

  void runFilter(String enteredKeyword) {
    List<TaskModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = getTaskListByClassFromUser;
    } else {
      results = getTaskListByClassFromUser
          .where((task) => task.description
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    filteredTaskList.value = results;
  }

  void resetDescriptionInput() {
    setDescription('');
  }
}
