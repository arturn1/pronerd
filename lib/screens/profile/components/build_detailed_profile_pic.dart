import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/controller/auth_controller.dart';
import 'package:pronerd/controller/profile_controller.dart';

import '../../../utils/constants.dart';

class DetailedProfilePic extends GetView<ProfileController> {
  const DetailedProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController auth = Get.find();

    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 48,
        backgroundImage: NetworkImage(controller.user.photoUrl),
      ),
    );
  }
}
