import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pronerd/controller/page_controller.dart';
import 'package:pronerd/controller/post_controller.dart';

import '../../../../utils/constants.dart';
import '../../../post/post_screen.dart';
import 'build_feed_card.dart';

class BuildFeedHome extends StatelessWidget {
  const BuildFeedHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageNavigationController pageController =
        Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20.0, bottom: 10, top: 20),
          child: Row(
            children: const [
              Text(
                'Posts recentes',
                style: kLabelHeadStyle,
              ),
              Spacer(),
              // Icon(
              //   Icons.arrow_right,
              //   size: 20,
              //   color: kOnPrimaryColorContainer10,
              // )
            ],
          ),
        ),
        NotificationListener<ScrollEndNotification>(
          onNotification: onNotification,
          child: GetX<PostController>(
              init: Get.put<PostController>(PostController()),
              builder: (PostController postController) {
                if (postController.postListByClassFromUser.value.isEmpty) {
                  return Container(
                      padding: const EdgeInsets.all(kPaddingDefault*2),
                      child: Column(
                        children: const [
                          Text("Os posts dos seus grupos apareceram aqui"),
                          Padding(
                            padding: EdgeInsets.all(kPaddingDefault*2),
                            child: Center(child: Icon(FontAwesomeIcons.camera,
                              size: 50,)),
                          )
                        ],
                      ));
                } else {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    //width: double.infinity,
                    height: 250,
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      controller: pageController.feedController.value,
                      itemCount: postController.postListByClassFromUser.value.isEmpty
                          ? postController.postListByClassFromUser.value.length
                          : postController.postListByClassFromUser.value.length > 3
                              ? 4
                              : postController.postListByClassFromUser.value.length,
                      itemBuilder: (_, index) {
                        return PostCard(
                            snap: postController.postListByClassFromUser.value[index]);
                      },
                    ),
                  );
                }
              }),
        ),
      ],
    );
  }
}

bool onNotification(ScrollEndNotification t) {
  final PageNavigationController pageController = Get.find();

  if (t.metrics.pixels > 0 && t.metrics.atEdge) {
    // Get.to(() => PostScreen(), arguments: 'notNull')
    //     ?.then((value) => pageController.feedController.value.jumpTo(0));
    pageController.navigateToPage(1);
  } else {
    print('I am at the start');
  }
  return true;
}
