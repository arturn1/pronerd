import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/controller/auth_controller.dart';
import 'package:pronerd/controller/user_controller.dart';
import 'package:pronerd/utils/constants.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    UserController userController = Get.find();

    return CircleAvatar(
      radius: 60,
      backgroundImage: NetworkImage(userController.userModel!.photoUrl),
    );
  }
}
