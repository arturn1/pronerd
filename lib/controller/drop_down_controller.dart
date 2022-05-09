
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pronerd/controller/user_controller.dart';
import 'package:pronerd/models/test.dart';

import '../models/room.dart';
import '../utils/constants.dart';
import 'auth_controller.dart';

class DropDownController extends GetxController {

  UserController userController = Get.find()
;
  @override
  void onInit() {
    super.onInit();
    classesList.bindStream(classStream());
  }

  Rx<List<RoomModel>> classesList = Rx<List<RoomModel>>([]);

  List<RoomModel> get classes => classesList.value;

  Stream<List<RoomModel>> classStream() {
    return firestore
        .collection("rooms")
        .where("followers", arrayContains: userController.userModel!.uid)
        .snapshots()
        .map((QuerySnapshot query) {
      //print(query.docs.map((e) => e.data().toString()));
      List<RoomModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(RoomModel.fromSnap(element));
      }
      return retVal;
    });
  }
}