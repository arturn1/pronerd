import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/controller/auth_controller.dart';
import 'package:pronerd/controller/drop_down_controller.dart';
import 'package:pronerd/controller/post_controller.dart';
import 'package:pronerd/controller/task_controller.dart';

class PageNavigationController extends GetxController {
  final AuthController auth = Get.find();
  DropDownController dropdown = Get.put(DropDownController());
  TaskController taskController = Get.find();
  PostController postController = Get.find();

  final RxInt page = 0.obs;
  var controller = PageController(initialPage: 0).obs;
  var baseController = ScrollController().obs;
  var feedController = ScrollController().obs;


  var isSearching = false.obs;

  final RxBool a = false.obs;

  hideBottomNav() => a.toggle();

  setFromController(value) => baseController = value;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  setPage(value) => page.value = value;

  // void closeDrawer() {
  //   scaffoldKey.currentState!.openEndDrawer();
  // }

  animateTo(int page) {
    controller.value.jumpToPage(page);
    setPage(page);
    //closeDrawer();
  }

  navigateToPage(int input) {
    if (controller.value.hasClients) {
      if(input == 2) taskController.updateList();
      if(input == 1) postController.updateList();
      controller.value.animateToPage(input,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      setPage(input);
    }
  }
}
