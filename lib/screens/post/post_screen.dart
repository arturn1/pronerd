import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pronerd/components/build_header.dart';
import 'package:pronerd/controller/post_controller.dart';

import '../../controller/date_picker_controller.dart';
import '../../utils/constants.dart';
import 'components/build_post_card.dart';

class PostScreen extends GetView<PostController> {
  PostScreen({Key? key}) : super(key: key);

  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {

    DateController dateController = Get.find();

    return Scaffold(
      body: Column(children: [
        const Center(child: CustomHeader(text: 'Posts')),
        Expanded(
          child: Column(
            children: [
              Container(
                // color: kPrimaryBarColor,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Obx(() => Text(controller.filteredPostList.value.length
                              .toString() +
                          ' posts encontrados'),
                    ),
                    const Spacer(),
                    const Text('Filtro    |'),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      child: const Icon(Icons.date_range),
                      onTap: () => dateController
                          .postDateFilter(context)
                          .then((value) => controller.runPostFilter(value)),
                    ),
                    const SizedBox(
                      width: 30,
                      child: Text('    |'),
                    ),
                    GestureDetector(
                      child: const Icon(Icons.cancel_rounded),
                      onTap: () => {}
                          //postController.resetPostList()
                    )
                  ],
                ),
              ),
              GetX<PostController>(
                  init: Get.put<PostController>(PostController()),
                  builder: (PostController postController) {
                    if (postController.filteredPostList.value.isEmpty) {
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
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          //controller: pageController.feedController.value,
                          itemCount: postController
                              .filteredPostList.value.length,
                          itemBuilder: (_, index) {
                            return PostCard(
                                snap: postController
                                    .filteredPostList.value[index]);
                          },
                        ),
                      );
                    }
                  }),
            ],
          ),
        )
      ]),
    );
  }
}
