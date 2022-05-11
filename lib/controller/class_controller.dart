import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pronerd/controller/user_controller.dart';
import 'package:pronerd/services/class_service.dart';
import 'package:uuid/uuid.dart';

import '../models/room.dart';

class ClassController extends GetxController with ClassService {
  UserController userController = Get.find();

  Future<void> onClick() async {
    classListByUser.bindStream(getClassStreamByUser());
  }

  @override
  void onInit() {
    super.onInit();
    classListByUser
        .bindStream(getClassStreamByUser()); //stream coming from firebase
    classList.bindStream(classStream()); //stream coming from firebase
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rx<List<RoomModel>> classListByUser = Rx<List<RoomModel>>([]);
  Rx<List<RoomModel>> classList = Rx<List<RoomModel>>([]);
  final RxString _name = ''.obs;
  RxBool isFollowing = false.obs;

  setIsFollowing(v) => isFollowing.value = v;

  List<RoomModel> get classListByUserT => classListByUser.value;

  setName(value) => _name.value = value;

  Future<void> addClass() async {
    String classId = const Uuid().v1();
    List<dynamic> uids = ([userController.userModel!.uid]);

    RoomModel roomModel = RoomModel(
        classId: classId,
        name: _name.value,
        uid: userController.userModel!.uid,
        userName: userController.userModel!.userName,
        dateCreated: DateTime.now(),
        followers: uids);

    addClassToDB(roomModel);
    reset();
  }

  Stream<List<RoomModel>> getClassStreamByUser() {
    return getClassStreamByUserFromDB(userController.userModel!);
  }

  Stream<List<RoomModel>> classStream() {
    return getClassStreamFromDB();
  }

  Future<bool> getUserIsFollowing(RoomModel snap) async {
    return setIsFollowing(
        await getUserIsFollowingFromDB(snap.classId, userController.userModel));
  }

  Future<void> followClass(String classId) async {
    var b = await getUserIsFollowingFromDB(classId, userController.userModel);
    if (b == false) {
      followClassToDB(classId, userController.userModel);
      setIsFollowing(!b);
    } else {
      unfollowClassToDB(classId, userController.userModel);
      setIsFollowing(!b);
    }
  }

  void reset() {
    setName('');
  }
}
