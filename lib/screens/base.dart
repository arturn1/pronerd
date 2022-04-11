import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/components/bottom_animated_bar/build_bottom_navigation_bar.dart';
import 'package:pronerd/components/build_snack_bar.dart';
import 'package:pronerd/components/build_snack_entry_source.dart';
import 'package:pronerd/controller/auth_controller.dart';
import 'package:pronerd/controller/page_controller.dart';
import 'package:pronerd/screens/post/post_screen.dart';
import 'package:pronerd/screens/task/task_screen.dart';
import 'package:pronerd/utils/constants.dart';

import '../components/bottomDrawer.dart';
import '../controller/class_controller.dart';
import '../controller/drop_down_controller.dart';
import '../controller/profile_controller.dart';
import '../controller/task_controller.dart';
import '../components/build_custom_appBar.dart';
import 'home/home_screen.dart';

class BaseScreen extends GetView {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TaskController taskController = Get.put(TaskController());
    ProfileController profileController = Get.put(ProfileController());
    DropDownController dropDownController = Get.put(DropDownController());
    ClassController classController = Get.put(ClassController());

    return Scaffold(
      backgroundColor: kPrimarySurface,
      appBar: const CustomAppBar(),
      body: SafeArea(child: Obx(() => getBody())),
      bottomNavigationBar: const AnimatedBottomDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
        backgroundColor: kSecondaryColorContainer90,
          elevation: 4,
          child: Icon(Icons.add,
          color: kOnSecondaryColorContainer10,
          ),
          onPressed: () => classController.classListByUserT.length.isGreaterThan(0) ?
            {
          // CustomSnack()
          //     .buildCardSuccess('Post salvo com sucesso'),
              Get.bottomSheet(const SelectImageSourceSnack()),
            // print(Get.height),
            //  print(Get.width),
            //  print(Get.mediaQuery),
            // print(Get.currentRoute == '/BaseScreen' ? 's': 'n'),
            taskController.onFollow()}
               : CustomSnack().buildCardInformation('Crie ou siga ao menos um grupo')
              ),
    );
  }
}

Widget getBody() {
  PageNavigationController pageController = Get.put(PageNavigationController());
  DropDownController dropDownController = Get.put(DropDownController());
  ClassController classController = Get.put(ClassController());


  return SafeArea(
    child: PageView(
      controller: pageController.controller.value,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const HomeScreen(),
        PostScreen(),
        const TaskScreen(),
        // const MyPostScreen(),
        // const ProfileScreen(),
      ],
    ),
  );
}
