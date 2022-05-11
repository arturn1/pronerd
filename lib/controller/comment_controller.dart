import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pronerd/components/build_snack_bar.dart';
import 'package:pronerd/controller/user_controller.dart';
import 'package:pronerd/models/comment.dart';
import 'package:pronerd/models/post.dart';
import 'package:pronerd/models/user.dart';
import 'package:pronerd/services/comment_service.dart';
import 'package:pronerd/utils/constants.dart';
import 'package:uuid/uuid.dart';

import 'auth_controller.dart';

class CommentController extends GetxController with CommentService {

  UserController userController = Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rx<List<CommentModel>> commentList = Rx<List<CommentModel>>([]);

  final RxString _comment = ''.obs;
  setComment(value) => _comment.value = value;

  Future<void> addComment(PostModel snap) async {
    try {
      addCommentToDB(snap.postId, userController.userModel, _comment.value);
      reset();
      formKey.currentState!.reset();
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<CommentModel>> getCommentStream(PostModel snap) {
    try {
      return getCommentStreamFromDB(snap.postId);
    } catch (e) {
      rethrow;
    }
  }

  void reset() {
    setComment('');
  }
}
