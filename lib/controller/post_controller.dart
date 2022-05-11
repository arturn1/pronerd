import 'dart:io';

import 'package:pronerd/controller/image_controller.dart';
import 'package:pronerd/controller/user_controller.dart';
import 'package:pronerd/models/post.dart';
import 'package:pronerd/services/post_service.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';

import 'class_controller.dart';
import 'date_picker_controller.dart';

class PostController extends GetxController with PostService {
  ClassController classController = Get.find();
  ImageController imageController = Get.put(ImageController());
  DateController dateController = Get.put(DateController());
  UserController userController = Get.find();

  @override
  void onReady() {
    myPostList.bindStream(getMyPostStream());
    postListByClassFromUser.bindStream(getPostStreamByClassFromUser());
  }

  Rx<List<PostModel>> myPostList = Rx<List<PostModel>>([]);
  Rx<List<PostModel>> postListByClass = Rx<List<PostModel>>([]);
  Rx<List<PostModel>> postListByClassFromUser = Rx<List<PostModel>>([]);
  Rx<List<PostModel>> filteredPostList = Rx<List<PostModel>>([]);

  final RxString _description = ''.obs;
  final RxString _classId = ''.obs;
  final RxString _className = ''.obs;
  final RxInt _commentLength = 0.obs;

  setDescription(value) => _description.value = value;

  setClassId(value) => _classId.value = value;

  setClassName(value) => _className.value = value;

  setCommentLength(v) => _commentLength.value = v;

  String get className => _className.value;

  int get commentLength => _commentLength.value;

  Future<void> onClick(String snap) async {
    postListByClass.bindStream(getPostStreamByClass(snap));
  }

  Future<void> onFollow() async {
    postListByClassFromUser.bindStream(getPostStreamByClassFromUser());
  }

  Future<void> addPost(File file) async {
    try {
      String photoUrl = await imageController.uploadImageToStorage(file, true);

      String postId = const Uuid().v1();
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

      addPostToDB(post);
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<PostModel>> getMyPostStream() {
    try {
      return getMyPostStreamFromDB(userController.userModel!);
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<PostModel>> getPostStreamByClass(String classId) {
    try {
      return getPostStreamByClassFromDB(classId);
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<PostModel>> getPostStreamByClassFromUser() {
    try{
      return getPostStreamByClassFromUserFromDB(userController.userModel);
    }catch(e){
      rethrow;
    }
  }

  updateList() {
    filteredPostList.value = postListByClassFromUser.value;
  }

  void runFilter(DateTime d) {
    List<PostModel> results = [];
    results = postListByClassFromUser.value
        .where((post) => post.datePublished.day == d.day)
        .toList();

    filteredPostList.value = results;
  }

// Future<String> likePost(String postId, String uid, List likes) async {
//   String res = "Some error occurred";
//   try {
//     if (likes.contains(uid)) {
//       // if the likes list contains the user uid, we need to remove it
//       firestore.collection('posts').doc(postId).update({
//         'likes': FieldValue.arrayRemove([uid])
//       });
//     } else {
//       // else we need to add uid to the likes array
//       firestore.collection('posts').doc(postId).update({
//         'likes': FieldValue.arrayUnion([uid])
//       });
//     }
//     res = 'success';
//   } catch (err) {
//     res = err.toString();
//   }
//   return res;
// }

// Delete post
// Future<String> deletePost(String postId) async {
//   String res = "Some error occurred";
//   try {
//     await firestore.collection('posts').doc(postId).delete();
//     res = 'success';
//   } catch (err) {
//     res = err.toString();
//   }
//   return res;
// }

// Stream<List<PostModel>> postStream() {
//   return firestore
//       .collection("posts")
//       // .where("uid", isEqualTo: auth.user.uid)
//       .orderBy("datePublished", descending: true)
//       .snapshots()
//       .map((QuerySnapshot query) {
//     List<PostModel> retVal = [];
//     for (var element in query.docs) {
//       retVal.add(PostModel.fromSnap(element));
//     }
//     return retVal;
//   });
// }

}
