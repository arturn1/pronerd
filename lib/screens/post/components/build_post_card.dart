import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pronerd/controller/comment_controller.dart';
import 'package:pronerd/models/post.dart';
import 'package:pronerd/screens/comment/comment_screen.dart';
import 'package:pronerd/utils/constants.dart';

import '../../../components/detailed_post.dart';
import '../../../controller/date_picker_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../profile/detailed_profile_screen.dart';
import '../../task/task_screen.dart';

class PostCard extends StatelessWidget {
  PostModel snap;

  PostCard({required this.snap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    CommentController commentController = Get.put(CommentController());
    // TaskController taskController = Get.find();
    DateController dateController = Get.find();

    return Container(
      height: Get.height * .35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderDefault),
        color: kPrimaryBarColor,
      ),
      margin: const EdgeInsets.all(kMarginDefault),
      child: Column(children: [
        Stack(
          children: [
            SizedBox(
              height: pixelDevice == 3 ? Get.height * .25 : Get.height * .28,
              width: double.infinity,
              child: GestureDetector(
                onTap: () => Get.to(() => DetailScreen(snap: snap)),
                child: Hero(
                  tag: snap.postId,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(kBorderDefault),
                        topRight: Radius.circular(kBorderDefault)),
                    child: CachedNetworkImage(
                      placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                        color: Colors.grey,
                      )),
                      fit: BoxFit.cover,
                      imageUrl: snap.postImageUrl,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10, // SizedBox(
              child: GestureDetector(
                onTap: () => profileController.updateUserId(snap.uid).then(
                    (value) => Get.to(() => const DetailedProfileScreen())),
                child: FittedBox(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(snap.userPhotoURL),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: kMarginDefault/2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      snap.className,
                      style: TextStyle(
                        fontSize:
                        Theme.of(context).textTheme.titleLarge?.fontSize,
                        color: kOnPrimaryColorContainer10,
                      ),
                    ),
                    Text(
                      dateController.showDateLikeInsta(snap.datePublished),
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleSmall?.fontSize,
                        color: kOnPrimaryColorContainer10,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: kMarginDefault),
                height: pixelDevice == 3
                    ? kHeightDefault / 14
                    : kHeightDefault / 18,
                child: TextButton.icon(
                    icon: const Icon(FontAwesomeIcons.comment, size: 25,),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(color: kPrimaryBarColor),
                      ),
                      primary: kOnPrimaryColorContainer10,
                      backgroundColor: kPrimaryBarColor,
                    ),
                    onPressed: () => {
                          commentController.onClick(snap).then(
                              (v) => Get.to(() => CommentsScreen(snap: snap)))
                        },
                    label: Text(snap.commentLenght.toString())),
              ),
              // SizedBox(
              //   // margin: const EdgeInsets.only(left: kMarginDefault/10),
              //   height: pixelDevice == 3
              //       ? kHeightDefault / 14
              //       : kHeightDefault / 18,
              //   child: IconButton(
              //       icon: const Icon(FontAwesomeIcons.star, size: 25,),
              //       onPressed: () => {doNothing(context)},
              //       // label: const Text('')
              //   ),
              // ),
            ],
          ),
        )
      ]),
    );
  }
}


