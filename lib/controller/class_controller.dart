import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pronerd/controller/user_controller.dart';
import 'package:pronerd/utils/constants.dart';
import 'package:uuid/uuid.dart';

import '../models/room.dart';

class ClassController extends GetxController {

  UserController userController = Get.find();

  Future<void> onClick() async {
    classListByUser.bindStream(classStreamByUser());
  }

  @override
  void onInit() {
    super.onInit();
    classListByUser.bindStream(classStreamByUser()); //stream coming from firebase
    classList.bindStream(classStream()); //stream coming from firebase
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: '_homekey');

  Rx<List<RoomModel>> classListByUser = Rx<List<RoomModel>>([]);
  Rx<List<RoomModel>> classList = Rx<List<RoomModel>>([]);
  final RxString _name = ''.obs;

  List<RoomModel> get classListByUserT => classListByUser.value;

  setName(value) => _name.value = value;

  Future<void> addClass() async {
    String res = "Some error occurred";
    try {
      if (_name.isNotEmpty) {
        String classId = const Uuid().v1();
        await firestore.collection('rooms').
        doc(classId).
        set({
          'name': _name.value,
          'uid': userController.userModel!.uid,
          'userName': userController.userModel!.userName,
          'classId': classId,
          'followers': FieldValue.arrayUnion([userController.userModel!.uid]),
          'dateCreated': DateTime.now()
        });
        DocumentSnapshot doc =
        await firestore.collection('users').doc(userController.userModel!.uid).get();
        await firestore.collection('users').doc(userController.userModel!.uid).update({
          'classes': FieldValue.arrayUnion([classId]),
        });
        reset();
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      rethrow;
    }
  }

  Stream<List<RoomModel>> classStreamByUser() {
    return firestore
        .collection("rooms")
        .where("followers", arrayContains: userController.userModel!.uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<RoomModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(RoomModel.fromSnap(element));
      }
      return retVal;
    });
  }

  Stream<List<RoomModel>> classStream() {
    return firestore
        .collection("rooms")
        .snapshots()
        .map((QuerySnapshot query) {
      List<RoomModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(RoomModel.fromSnap(element));
      }
      return retVal;
    });
  }


  void reset() {
    setName('');
  }

  // var userData = {};
  // int postLen = 0;
  // int followers = 0;
  // int following = 0;
  // bool isFollowing = false;
  RxBool isFollowing = false.obs;
  setIsFollowing(v) => isFollowing.value = v;

  Future <void> getData(RoomModel snap) async {
    var room = await firestore
        .collection('rooms')
        .doc(snap.classId)
        .get();

    bool following = room
        .data()!['followers']
        .contains(userController.userModel!.uid);
    setIsFollowing(following);
    // print(following);
  }

  // Future <bool> isFollow(String classId) async {
  //   var room = await FirebaseFirestore.instance
  //       .collection('rooms')
  //       .doc(classId)
  //       .get();
  //
  //   return room
  //       .data()!['followers']
  //       .contains(auth.user.uid);
  //   // setIsFollowing(following);
  //   // print(following);
  // }

  Future<void> followClass(String classId) async {
    try {
      DocumentSnapshot snap =
      await firestore.collection('rooms').doc(classId).get();
      List following = (snap.data()! as dynamic)['followers'];

      if (following.contains(userController.userModel!.uid)) {
        await firestore.collection('rooms').doc(classId).update({
          'followers': FieldValue.arrayRemove([userController.userModel!.uid])
        });

        DocumentSnapshot doc =
        await firestore.collection('users').doc(userController.userModel!.uid).get();
        await firestore.collection('users').doc(userController.userModel!.uid).update({
          'classes': FieldValue.arrayRemove([classId]),
        });
        setIsFollowing(false);

        // await auth.firestore.collection('users').doc(uid).update({
        //   'following': FieldValue.arrayRemove([followId])
        // });
      } else {
        await firestore.collection('rooms').doc(classId).update({
          'followers': FieldValue.arrayUnion([userController.userModel!.uid])
        });

        DocumentSnapshot doc =
        await firestore.collection('users').doc(userController.userModel!.uid).get();
        await firestore.collection('users').doc(userController.userModel!.uid).update({
          'classes': FieldValue.arrayUnion([classId]),
        });
        setIsFollowing(true);


        // await auth.firestore.collection('rooms').doc(uid).update({
        //   'following': FieldValue.arrayUnion([followId])
        // });
        // postController.postStreamByClassFromUser;
         classStreamByUser;
      }
    } catch (e) {
      //CustomSnack().buildCardError(e.toString());
    }
  }


}
