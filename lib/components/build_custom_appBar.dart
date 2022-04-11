import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pronerd/screens/profile/detailed_profile_screen.dart';

import '../controller/auth_controller.dart';
import '../controller/profile_controller.dart';
import '../utils/constants.dart';
import '../screens/profile/profile_screen.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar(
      {Key? key, this.preferredSize = const Size.fromHeight(100)})
      : super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.find();
    final ProfileController profileController = Get.find();

    return SafeArea(
      child: PreferredSize(
        preferredSize: preferredSize,
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: kPrimaryBarColor,
          flexibleSpace: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 20),
                child: InkWell(
                  onTap: () => Get.to(() => const ProfileScreen()),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      auth.user.photoURL == null
                          ? 'https://avatars.githubusercontent.com/u/31557902?v=4'
                          : auth.user.photoURL!,
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: 30.0, left: pixelDevice == 3 ? 50 : 80),
                  child: Text(
                    'PRO NERD',
                    style: TextStyle(
                      color: kOnPrimaryColorContainer10,
                      fontSize: Theme.of(context).textTheme.headline4?.fontSize,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
