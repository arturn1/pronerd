import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pronerd/components/build_snack_bar.dart';
import 'package:pronerd/models/comment.dart';
import 'package:pronerd/models/post.dart';
import 'package:pronerd/utils/constants.dart';
import 'package:uuid/uuid.dart';

import 'auth_controller.dart';

class CommentController extends GetxController {
  AuthController auth = Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: '_homekey');

  Rx<List<CommentModel>> commentList = Rx<List<CommentModel>>([]);
  final RxString _comment = ''.obs;
  final RxInt _commentLen = 0.obs;


  setComment(value) => _comment.value = value;

  // setCommentLen(value) => _commentLen.value = value;
  // getCommentLen() => _commentLen.value;

  Future<void> onClick(PostModel snap) async {
    //String uid = Get.find<AuthController>().user.uid;
    commentList
        .bindStream(commentStream(snap)); //stream coming from firebase
  }

  // post comment
  Future<String> addComment(PostModel snap) async {
    String res = "Some error occurred";
    try {
      if (_comment.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        auth.firestore
            .collection('comments')
            .doc(snap.postId)
            .collection('commentByPost')
            .doc(commentId)
            .set({
          'commentId': commentId,
          'description': _comment.value,
          'uid': auth.user.uid,
          'userName': auth.user.displayName,
          'userPhotoURL': auth.user.photoURL,
          'datePublished': DateTime.now(),
          'postId': snap.postId,
        });
        reset();
        formKey.currentState!.reset();
        res = 'post Criado com sucesso';
        DocumentSnapshot doc =
        await firestore.collection('posts').doc(snap.postId).get();
        await firestore.collection('posts').doc(snap.postId).update({
          'commentLength': (doc.data()! as dynamic)['commentLength'] + 1,
        });
        //CustomSnack().buildCardSuccess(res);

      } else {
        //CustomSnack().buildCardError(res);
        res = "Please enter text";
      }
    } catch (err) {
      //CustomSnack().buildCardError(err.toString());
    }
    return res;
  }

  Stream<List<CommentModel>> commentStream(PostModel snap) {
    return firestore
    .collection('comments')
    .doc(snap.postId)
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

  void reset() {
    setComment('');
  }

  // Future<int> fetchCommentLen(PostModel snap) async {
  //   try {
  //     QuerySnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('comments')
  //         .doc(snap.postId)
  //         .collection('commentByPost')
  //         .get();
  //     return setCommentLen(snapshot.docs.length);
  //   } catch (err) {
  //     CustomSnack().buildCardError(err.toString());
  //   }
  //   return CustomSnack().buildCardError('Algo deu errado!');
  //
  // }


}
