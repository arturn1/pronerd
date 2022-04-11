import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/controller/auth_controller.dart';

import '../../components/build_custom_appBar.dart';
import '../../controller/profile_controller.dart';
import '../../utils/constants.dart';
import 'components/build_detailed_profile_pic.dart';
import 'components/build_profile_menu.dart';
import 'components/build_profile_pic.dart';

class DetailedProfileScreen extends GetView<ProfileController> {
  const DetailedProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController auth = Get.find();

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight:Radius.circular(15) ),
            color: kPrimaryBarColor,
            ),
            child: Column(
              children: [
                const DetailedProfilePic(),
                SizedBox(
                  width: Get.width,
                  height: 100,
                  child: Center(
                    child: Text(controller.user.userName,
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline4?.fontSize
                    ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Center(
                //   child: Text(controller.user.bio,
                //     style: TextStyle(
                //         fontSize: Theme.of(context).textTheme.headline4?.fontSize
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: ProfileMenu(
      //   text: "Sair",
      //   icon: "assets/icons/Log out.svg",
      //   press: () => auth.signOut(),
      // ),
    );
  }
}
