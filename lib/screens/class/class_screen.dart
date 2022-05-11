import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/screens/class/components/task/build_tasks.dart';
import 'package:pronerd/components/build_custom_appBar.dart';

import '../../controller/class_controller.dart';
import '../../controller/date_picker_controller.dart';
import '../../controller/post_controller.dart';
import '../../controller/task_controller.dart';
import '../../models/room.dart';
import '../../utils/constants.dart';
import 'components/post/build_post_card_class.dart';

class ClassFeed extends StatelessWidget {
  const ClassFeed({Key? key, required this.roomModel}) : super(key: key);

  final RoomModel roomModel;

  @override
  Widget build(BuildContext context) {
    ClassController classController = Get.find();
    PostController postController = Get.find();
    TaskController taskController = Get.find();

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: kPrimarySurface,
          child: CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                flexibleSpace: CustomAppBar(),
                collapsedHeight: 100,
                expandedHeight: 100,
              ),
              CustomSliverHeaderRoomNameAndFollowBtn(roomModel: roomModel),
              SliverToBoxAdapter(
                  child: Obx(
                () => Container(
                  color: kPrimaryBarColor,
                  child: AnimatedCrossFade(
                    duration: const Duration(milliseconds: 500),
                    sizeCurve: Curves.easeIn,
                    crossFadeState: classController.isFollowing.isTrue
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: kMarginDefault / 2),
                      child: OutlinedButton(
                          onPressed: () => {
                                classController
                                    .followClass(roomModel.classId)
                                    .then(
                                      (value) => taskController.updateHome(),
                                    )
                              },
                          style: OutlinedButton.styleFrom(
                            elevation: 2,
                            backgroundColor: kSecondaryColorContainer90,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            // elevation: 2,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          child: Text(
                            'Seguindo',
                            style:
                                TextStyle(color: kOnSecondaryColorContainer10),
                          )),
                    ),
                    secondChild: Container(
                      width: double.infinity,
                      // color: kOnSecondaryColorContainer10,
                      margin: const EdgeInsets.symmetric(
                          horizontal: kMarginDefault / 2),
                      child: OutlinedButton(
                        onPressed: () => {
                          classController.followClass(roomModel.classId).then(
                                (value) => taskController.updateHome(),
                              )
                        },
                        style: OutlinedButton.styleFrom(
                          elevation: 2,
                          backgroundColor: kOnSecondaryColorContainer10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          // elevation: 2,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        child: Text(
                          'Seguir',
                          style: TextStyle(color: kSecondaryColorContainer90),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
              SliverList(
                delegate: SliverChildListDelegate([
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: BuildClassTasks(),
                  ),
                ]),
              ),
              const CustomSliverHeaderPosts(),
              // SliverList(
              //   //itemExtent: 115,
              //   delegate: SliverChildListDelegate([
              //     const BuildPostTasks(),
              //   ]),
              // ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // mainAxisSpacing: 10,
                  // crossAxisSpacing: 10,
                  // childAspectRatio: 2.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return PostCardClass(
                        snap: postController.postListByClass.value[index]);
                  },
                  childCount: postController.postListByClass.value.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSliverHeaderPosts extends StatelessWidget {
  const CustomSliverHeaderPosts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: Delegate(),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  Delegate();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: kPrimarySurface,
      child: Center(
        child: Text(
          'Posts',
          style: TextStyle(
            color: kOnPrimaryColorContainer10,
            fontSize: 25,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class CustomSliverHeaderRoomNameAndFollowBtn extends StatelessWidget {
  final RoomModel roomModel;

  const CustomSliverHeaderRoomNameAndFollowBtn(
      {Key? key, required this.roomModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: true,
      delegate: DelegateRoomNameAndFollowBtn(roomModel),
    );
  }
}

class DelegateRoomNameAndFollowBtn extends SliverPersistentHeaderDelegate {
  final RoomModel roomModel;

  DelegateRoomNameAndFollowBtn(this.roomModel);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    DateController dateController = Get.find();

    ClassController classController = Get.find();
    //PostController postController = Get.find();
    TaskController taskController = Get.find();

    return Column(
      children: [
        Container(
          color: kPrimaryBarColor,
          height: 70,
          width: double.infinity,
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  child: const Icon(Icons.arrow_back_rounded),
                  onTap: () => Get.back(),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                roomModel.name,
                style: TextStyle(
                  fontSize: 25,
                  letterSpacing: .01,
                  color: kOnPrimaryColorContainer10,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'myFont',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
