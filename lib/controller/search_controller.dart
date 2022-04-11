import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/controller/task_controller.dart';
import 'package:pronerd/models/post.dart';

import '../models/room.dart';
import '../models/task.dart';
import '../utils/constants.dart';
import 'class_controller.dart';

class SearchController extends GetxController {

  TaskController taskController = Get.find();
  ClassController classController = Get.find();

  final Rx<List<RoomModel>> _filteredRoomList = Rx<List<RoomModel>>([]);
  final Rx<List<TaskModel>> _filteredTaskList = Rx<List<TaskModel>>([]);

  List<RoomModel> get searchedRoomList => _filteredRoomList.value;

  List<TaskModel> get searchedTaskList => _filteredTaskList.value;


  GlobalKey<FormState> formKey =
  GlobalKey<FormState>(debugLabel: '_homeScreenkey');
  TextEditingController textController = TextEditingController();

  //List<RoomModel> get searchedPosts => _searchedPosts.value;

  final RxString _search = ''.obs;

  String get search => _search.value;

  setSearch(value) => _search.value = value;

  final Rx<DateTime> _searchDate = DateTime
      .now()
      .obs;

  DateTime get searchDate => _searchDate.value;

  setSearchDate(value) => _searchDate.value = value;

  setIsSearching(v) => isSearching.value = v;

  //final Rx<List<RoomModel>> _searchedPosts = Rx<List<RoomModel>>([]);
  var isSearching = false.obs;

  void reset() {
    //formKey.currentState!.reset();
    setSearch('');
  }

  showCorrectDate(DateTime d) {
    return "${d.day}/${d.month}/${d.year}";
  }

  presentDatePicker(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: _searchDate.value,
        firstDate: DateTime(2020),
        lastDate: DateTime(2024));
    // Check if no date is selected
    if (selected == null) {
      return;
    }
    textController.text = showCorrectDate(selected);
    setSearchDate(selected);
  }

  searchRoom(String typedUser) {
    if (typedUser.isNotEmpty) {
      _filteredRoomList.bindStream(firestore
          .collection('rooms')
          .where('name', isGreaterThanOrEqualTo: typedUser)
          .snapshots()
          .map((QuerySnapshot query) {
        List<RoomModel> retVal = [];
        for (var elem in query.docs) {
          retVal.add(RoomModel.fromSnap(elem));
        }
        return retVal;
      }));
    } else {
      return null;
    }
  }

  searchRoomInsensitive(String typedUser) {
    _filteredRoomList.bindStream(firestore
        .collection('rooms')
        .snapshots()
        .map((QuerySnapshot query) {
      List<RoomModel> results = [];
      for (var elem in query.docs) {
        var room = RoomModel.fromSnap(elem);
        if (room.name.toLowerCase().contains(typedUser.toLowerCase())) {
          results.add(room);
        }
      }
      return results;
    }));
  }

  // searchTaskInsensitive(String typedUser) {
  //   _filteredTaskList.bindStream(firestore
  //       .collection("tasks")
  //   // .where("followers", arrayContains: auth.userModel!.uid)
  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     List<TaskModel> retVal = [];
  //     for (var element in query.docs) {
  //
  //       var taskModel = (TaskModel.fromSnap(element));
  //       var classId = (TaskModel.fromSnap(element)).classId;
  //       for (var f in classController.classListByUserT) {
  //         if (f.classId == classId && taskModel.description.toLowerCase().contains(typedUser.toLowerCase())) {
  //           retVal.add(taskModel);
  //         }
  //       }
  //     }
  //     retVal.sort((a,b) => a.finalDate.compareTo(b.finalDate));
  //     return retVal;
  //   }));
  // }


}
