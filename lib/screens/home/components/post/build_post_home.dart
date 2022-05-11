import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:pronerd/controller/page_controller.dart';
import 'package:pronerd/controller/post_controller.dart';
import 'package:pronerd/screens/home/components/post/build_post_card.dart';

import '../../../../models/post.dart';
import '../../../../utils/constants.dart';

class BuildPostHome extends StatelessWidget {
  const BuildPostHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.find();

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
            ],
          ),
        ),
        NotificationListener<ScrollEndNotification>(
          onNotification: onNotification,
          child: StreamBuilder<List<PostModel>>(
              stream: postController.getPostStreamByClassFromUser(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  if (!snapshot.hasData) {
                    postController.postListByClassFromUser
                        .bindStream(postController.getPostStreamByClassFromUser());
                  }
                  return const Center(
                    child: GFLoader(
                      type: GFLoaderType.ios,
                    ),
                  );
                }

                if (snapshot.data!.isEmpty) {
                  return Container(
                      padding: const EdgeInsets.all(kPaddingDefault * 2),
                      child: Column(
                        children: const [
                          Text("Os posts dos seus grupos apareceram aqui"),
                          Padding(
                            padding: EdgeInsets.all(kPaddingDefault * 2),
                            child: Center(
                                child: Icon(
                              FontAwesomeIcons.camera,
                              size: 50,
                            )),
                          )
                        ],
                      ));
                }
                if (snapshot.hasData) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    height: 250,
                    child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (_, index) =>
                            PostCard(snap: snapshot.data![index])),
                  );
                }
                return const Center(
                  child: GFLoader(
                    type: GFLoaderType.ios,
                  ),
                );
              }),
        ),
      ],
    );
  }
}

bool onNotification(ScrollEndNotification t) {
  final PageNavigationController pageController = Get.find();

  if (t.metrics.pixels > 0 && t.metrics.atEdge) {
    pageController.navigateToPage(1);
  }
  return true;
}
