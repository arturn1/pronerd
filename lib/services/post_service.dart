import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pronerd/models/user.dart';

import '../models/post.dart';
import '../utils/constants.dart';

abstract class PostService {
  Future<void> addPostToDB(PostModel postModel) async {
    try {
      firestore
          .collection('posts')
          .doc(postModel.postId)
          .set(postModel.toJson());
    } catch (err) {
      rethrow;
    }
  }

  Stream<List<PostModel>> getMyPostStreamFromDB(UserModel userModel) {
    return firestore
        .collection("posts")
        .where("uid", isEqualTo: userModel.uid)
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

  Stream<List<PostModel>> getPostStreamByClassFromDB(String classId) {
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

  Stream<List<PostModel>> getPostStreamByClassFromUserFromDB(UserModel? user) {
    return firestore.collection("posts").snapshots().map((QuerySnapshot query) {
      List<PostModel> retVal = [];
      for (var element in query.docs) {
        var postModel = (PostModel.fromSnap(element));
        for (var c in user!.classes) {
          if (c == postModel.classId) {
            retVal.add(postModel);
          }
        }
      }
      retVal.sort((a, b) => a.datePublished.compareTo(b.datePublished));
      return retVal.reversed.toList();
    });
  }

  Future<List<PostModel>> futurePostStreamByClassFromUserFromDB(UserModel? user) async {
    return await firestore.collection("posts").get().then((QuerySnapshot query) async {
      List<PostModel> retVal = [];
      for (var element in query.docs) {
        var postModel = (PostModel.fromSnap(element));
        for (var c in user!.classes) {
          if (c == postModel.classId) {
            retVal.add(postModel);
          }
        }
      }
      retVal.sort((a, b) => a.datePublished.compareTo(b.datePublished));
      return retVal.reversed.toList();
    });
  }
}
