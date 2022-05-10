import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pronerd/controller/comment_controller.dart';
import 'package:pronerd/models/post.dart';
import 'package:pronerd/screens/comment/comment_screen.dart';
import 'package:pronerd/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../components/build_snack_bar.dart';
import '../../../../components/detailed_post.dart';
import '../../../../controller/date_picker_controller.dart';
import '../../../../controller/profile_controller.dart';
import '../../../profile/detailed_profile_screen.dart';

class PostCardClass extends StatelessWidget {
  final PostModel snap;

  const PostCardClass({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CommentController commentController = Get.put(CommentController());
    ProfileController profileController = Get.find();
    DateController dateController = Get.find();

    return Container(
      padding: const EdgeInsets.all(kMarginDefault / 3),
      child: Stack(children: [
        SizedBox(
          height: 200,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              child: GestureDetector(
                onTap: () => {Get.to(() => DetailScreen(snap: snap))},
                child: Hero(
                  tag: snap.postId,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: snap.postImageUrl,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              color: Colors.grey,
            ),
          ),
        ),
        Positioned(
          top: 11,
          left: 14,
          child: SizedBox(
            height: 38,
            width: pixelDevice == 3 ? Get.width * .28 : Get.width * .25,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.white,
                  ),
                color: Colors.black45
              ),
              child: Container(
                padding: EdgeInsets.only(top: pixelDevice == 3 ? 10 : 11, left: 38),
                child: AutoSizeText(
                  dateController.showDateLikeInsta(snap.datePublished),
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleSmall?.fontSize,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 12,
          left: 15,
          child: SizedBox(
            height: 36,
            width: 36,
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
          bottom: 10,
          left: Get.width * .25,
          child: SizedBox(
            height: 40,
            width: Get.width * .20,
            child: TextButton.icon(
              icon: const Icon(FontAwesomeIcons.comment),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: const BorderSide(color: Colors.white),
                ),
                primary: Colors.white,
                backgroundColor: Colors.black45,
              ),
              onPressed: () => {


                  Get.to(() => CommentsScreen(snap: snap))

              },
              label: Text(snap.commentLength.toString()),
            ),
          ),
        ),
      ]),
    );
  }
}