import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../models/comment.dart';
import '../models/user.dart';
import '../utils/constants.dart';

abstract class CommentService {

  Stream<List<CommentModel>> getCommentStreamFromDB(String postId) {
    return firestore
        .collection('comments')
        .doc(postId)
        .collection('commentByPost')
        .snapshots()
        .map((QuerySnapshot query) {
      List<CommentModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(CommentModel.fromSnap(element));
      }
      return retVal;
    });
  }


  Future<void> addCommentToDB(String postId, UserModel? user, String comment) async {
    try {
      String commentId = const Uuid().v1();
      firestore
          .collection('comments')
          .doc(postId)
          .collection('commentByPost')
          .doc(commentId)
          .set({
        'commentId': commentId,
        'description': comment,
        'uid': user!.uid,
        'userName': user.userName,
        'userPhotoURL': user.photoUrl,
        'datePublished': DateTime.now(),
        'postId': postId,
      });
      DocumentSnapshot doc =
          await firestore.collection('posts').doc(postId).get();
      await firestore.collection('posts').doc(postId).update({
        'commentLength': (doc.data()! as dynamic)['commentLength'] + 1,
      });
    } catch (e) {
      rethrow;
    }
  }
}
