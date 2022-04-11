import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/controller/page_controller.dart';
import 'package:pronerd/controller/post_controller.dart';

import '../../../../utils/constants.dart';
import '../../../post/post_screen.dart';
import 'build_post_card_class.dart';

class BuildPostTasks extends StatelessWidget {
  const BuildPostTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageNavigationController pageController =
    Get.find();

    return GetX<PostController>(
        init: Get.put<PostController>(PostController()),
        builder: (PostController postController) {
          if (postController.postListByClass.value.isEmpty) {
            return Container(
                padding: EdgeInsets.all(kPaddingDefault),
                child: const Center(child: Text('Ainda não há posts nesta matéria')));
          } else {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 0),
              shrinkWrap: true,
              itemCount: postController.postListByClass.value.isEmpty
                  ? postController.postListByClass.value.length
                  : postController.postListByClass.value.length > 4
                      ? 5
                      : postController.postListByClass.value.length,
              itemBuilder: (_, index) => PostCardClass(
                  snap: postController.postListByClass.value[index]),
            );
          }
        });
  }
}
