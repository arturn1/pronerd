import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pronerd/controller/comment_controller.dart';
import 'package:pronerd/models/post.dart';
import 'package:pronerd/screens/comment/comment_screen.dart';
import 'package:pronerd/screens/profile/detailed_profile_screen.dart';
import 'package:pronerd/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../components/detailed_post.dart';
import '../../../../controller/profile_controller.dart';
import '../../../../controller/task_controller.dart';

class PostCard extends StatelessWidget {
  final PostModel snap;

  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CommentController commentController = Get.put(CommentController());
    ProfileController profileController = Get.put(ProfileController());

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kPrimaryBarColor,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(children: [
        SizedBox(
          height: 195,
          width: 280,
          child: GestureDetector(
            onTap: () => {Get.to(() => DetailScreen(snap: snap))},
            child: Hero(
              tag: snap.postId,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: CachedNetworkImage(
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
          top: 20,
          left: 20,
          child: SizedBox(
            height: 38,
            width: 38,
            child: GestureDetector(
              onTap: () => profileController
                  .updateUserId(snap.uid)
                  .then((value) => Get.to(() => const DetailedProfileScreen())),
              child: CircleAvatar(
                backgroundImage: NetworkImage(snap.userPhotoURL),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 9,
          left: 10,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: kOnPrimaryColorContainer10,
                ),
                color: kPrimaryColorContainer90,
                borderRadius: BorderRadius.circular(25)),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
                height: 38,
                width: 150,
                child: Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      snap.className,
                      minFontSize: 4,
                      style: TextStyle(
                        fontSize: 16,
                        color: kOnPrimaryColorContainer10,
                      ),
                    ),
                  ),
                )),
          ),
        ),
        Positioned(
          bottom: 9,
          left: Get.width * .52,
          child: SizedBox(
            height: 40,
            width: 66,
            child: TextButton.icon(
              icon: const Icon(FontAwesomeIcons.comment),
              style: TextButton.styleFrom(
                // elevation: 2,
                shadowColor: kOnSecondaryColorContainer10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: BorderSide(color: kOnSecondaryColorContainer10),
                ),
                primary: kOnSecondaryColorContainer10,
                backgroundColor: kSecondaryColorContainer90,
              ),
              onPressed: () => {

                    Get.to(() => CommentsScreen(snap: snap))

                // .then((value) => fetchCommentLen())
              },
              label: Text(snap.commentLength.toString()),
            ),
          ),
        ),
      ]),
    );
  }
}
