import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/components/build_input_form.dart';
import 'package:pronerd/controller/auth_controller.dart';
import 'package:pronerd/controller/user_controller.dart';

import '../../components/build_custom_appBar.dart';
import '../../components/build_loading_page.dart';
import '../../components/build_loading_page_login.dart';
import '../../utils/constants.dart';
import '../base.dart';
import '../login/login_screen.dart';
import 'components/build_profile_menu.dart';
import 'components/build_profile_pic.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AuthController auth = Get.find();
    UserController userController = Get.find();

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(bottom: kMarginDefault),
            decoration: BoxDecoration(
                color: kPrimaryBarColor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(userController.userModel!.photoUrl),
                ),
                SizedBox(
                  width: Get.width,
                  height: 70,
                  child: Center(
                    child: Text(
                      userController.userModel!.userName,
                      style: TextStyle(
                        fontSize: 40,
                        letterSpacing: .05,
                        color: kOnPrimaryColorContainer10,
                      ),
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SizedBox(
                //       width: kWidthDefault/1.5,
                //       child:  Obx(() => TextFormField(
                //           autofocus: false,
                //           cursorColor: Colors.grey,
                //           onChanged: (v) => auth.setBio(v),
                //           keyboardType: TextInputType.emailAddress,
                //           style: const TextStyle(
                //             color: Colors.grey,
                //           ),
                //           decoration: InputDecoration(
                //             contentPadding: const EdgeInsets.only(top: 18.0),
                //             prefixIcon: const Icon(Icons.person),
                //             suffixIcon: InkWell(
                //               child: const Icon(Icons.refresh),
                //               onTap: () => auth.refreshBio(),
                //             ),
                //             hintText: auth.user.,
                //             hintStyle: const TextStyle(
                //               color: Colors.grey,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // ProfileMenu(
                //   text: "My Account",
                //   icon: "assets/icons/User Icon.svg",
                //   press: () => {},
                // ),
                // ProfileMenu(
                //   text: "Notifications",
                //   icon: "assets/icons/Bell.svg",
                //   press: () {},
                // ),
                // ProfileMenu(
                //   text: "Settings",
                //   icon: "assets/icons/Settings.svg",
                //   press: () {},
                // ),
                // ProfileMenu(
                //   text: "Help Center",
                //   icon: "assets/icons/Question mark.svg",
                //   press: () {},
                // ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ProfileMenu(
        text: "Sair",
        icon: "assets/icons/Log out.svg",
        press: () => Get.to(() => CustomLoaderLogin(
                getData: auth.signOut(),
          getBack: () => Get.to(() => const LoginScreen()),

        ),
    )));
  }
}
