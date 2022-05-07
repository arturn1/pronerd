import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/controller/auth_controller.dart';
import 'package:pronerd/controller/comment_controller.dart';
import 'package:pronerd/models/post.dart';

import '../../components/build_header.dart';
import '../../utils/constants.dart';
import 'components/comment_card.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({Key? key, required this.snap}) : super(key: key);

  final PostModel snap;

  @override
  Widget build(BuildContext context) {
    CommentController commentController = Get.find();
    AuthController authController = Get.find();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: kPrimaryBarColor,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: GestureDetector(
                        child: const Icon(Icons.arrow_back_rounded),
                        onTap: () => Get.back(),
                      ),
                    ),
                    const SizedBox(
                      width:20
                    ),
                    const CustomHeader(text: 'Comentários')
                  ]),
            ),
            GetX<CommentController>(
              init: Get.put<CommentController>(CommentController()),
              builder: (CommentController commentController) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: commentController.commentList.value.length,
                    itemBuilder: (_, index) => CommentCard(
                      snap: commentController.commentList.value[index],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // text input
      bottomNavigationBar: SafeArea(
        child: Container(
          color: kPrimaryInputColor,
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(authController.user.photoURL!),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: Form(
                    key: commentController.formKey,
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (v) => commentController.setComment(v),
                      decoration: InputDecoration(
                          hintText: '@${authController.user.displayName}',
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => commentController.addComment(snap),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Icon(Icons.send),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
