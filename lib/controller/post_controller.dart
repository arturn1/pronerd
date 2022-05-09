import 'dart:io';

import 'package:pronerd/controller/image_controller.dart';
import 'package:pronerd/controller/user_controller.dart';
import 'package:pronerd/models/post.dart';
import 'package:pronerd/screens/base.dart';
import 'package:pronerd/utils/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';
import 'class_controller.dart';
import 'date_picker_controller.dart';

class PostController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ClassController classController = Get.find();
  ImageController imageController = Get.put(ImageController());
  DateController dateController = Get.put(DateController());
  UserController userController = Get.find();

  @override
  void onReady() {
    postList.bindStream(postStream()); //stream coming from firebase
    myPostList.bindStream(myPostStream());
    postListByClassFromUser.bindStream(postStreamByClassFromUser());
  }

  Rx<List<PostModel>> postList = Rx<List<PostModel>>([]);
  Rx<List<PostModel>> myPostList = Rx<List<PostModel>>([]);
  Rx<List<PostModel>> postListByClass = Rx<List<PostModel>>([]);
  Rx<List<PostModel>> postListByClassFromUser = Rx<List<PostModel>>([]);

  final Rx<List<PostModel>> filteredPostList = Rx<List<PostModel>>([]);


  final RxString _description = ''.obs;
  final RxString _classId = ''.obs;
  final RxString _className = ''.obs;
  final RxInt _commentLength = 0.obs;

  String get className => _className.value;

  setDescription(value) => _description.value = value;

  setClassId(value) => _classId.value = value;

  setClassName(value) => _className.value = value;

  setCommentLength(v) => _commentLength.value = v;

  int get commentLength => _commentLength.value;

  Future<void> onClick(String snap) async {
    postListByClass.bindStream(postStreamByClass(snap));
  }

  Future<void> onFollow() async {
    postListByClassFromUser.bindStream(postStreamByClassFromUser());
  }

  Future<void> addPost(File file) async {
    try {
      String photoUrl = await imageController.uploadImageToStorage(file, true);
      String postId = const Uuid().v1(); // creates unique id based on time
      PostModel post = PostModel(
          postId: postId,
          commentLength: 0,
          description: _description.value,
          uid: userController.userModel!.uid,
          userName: userController.userModel!.userName,
          datePublished: DateTime.now(),
          postImageUrl: photoUrl,
          userPhotoURL: userController.userModel!.photoUrl,
          classId: _classId.value,
          className: _className.value);
      firestore.collection('posts').doc(postId).set(post.toJson());
      Get.back();
      Get.back();
      updateList();
    } catch (err) {
      //CustomSnack().buildCardError(err.toString());
    }
  }

  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Delete post
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Stream<List<PostModel>> postStream() {
    return firestore
        .collection("posts")
        // .where("uid", isEqualTo: auth.user.uid)
        .orderBy("datePublished", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<PostModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(PostModel.fromSnap(element));
      }
      return retVal;
    });
  }

  Stream<List<PostModel>> myPostStream() {
    return firestore
        .collection("posts")
        .where("uid", isEqualTo: userController.userModel!.uid)
        .orderBy("datePublished", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<PostModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(PostModel.fromSnap(element));
      }
      return retVal;
    });
  }

  Stream<List<PostModel>> postStreamByClass(String classId) {
    return firestore
        .collection("posts")
        .where("classId", isEqualTo: classId)
        .orderBy("datePublished", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<PostModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(PostModel.fromSnap(element));
      }
      return retVal;
    });
  }

  Stream<List<PostModel>> postStreamByClassFromUser() {
    return firestore
        .collection("posts")
        // .where("followers", arrayContains: auth.userModel!.uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<PostModel> retVal = [];
      for (var element in query.docs) {
        var postModel = (PostModel.fromSnap(element));
        var classId = (PostModel.fromSnap(element)).classId;
        for (var f in classController.classListByUserT) {
          if (f.classId == classId) {
            //return retVal;
            retVal.add(postModel);
          }
        }
      }
      retVal.sort((a, b) => a.datePublished.compareTo(b.datePublished));
      return retVal.reversed.toList();
    });
  }

  updateList()  {
    filteredPostList.value = postListByClassFromUser.value;
  }

  void runFilter(DateTime v) {
    List<PostModel> results = [];
      results = postListByClassFromUser.value
          .where((post) =>
          post.datePublished.day == v.day)
          .toList();

    filteredPostList.value = results;
    print(filteredPostList.value);
  }
}
