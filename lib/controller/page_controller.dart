import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/controller/auth_controller.dart';
import 'package:pronerd/controller/drop_down_controller.dart';
import 'package:pronerd/controller/post_controller.dart';
import 'package:pronerd/controller/task_controller.dart';

class PageNavigationController extends GetxController {

  // final AuthController auth = Get.find();
  DropDownController dropdown = Get.put(DropDownController());
  TaskController taskController = Get.find();
  PostController postController = Get.find();

  final RxInt page = 0.obs;
  Rx<PageController> controller = PageController(initialPage: 0).obs;
  var baseController = ScrollController().obs;
  var feedController = ScrollController().obs;

  PageController get getController => controller.value;

  var isSearching = false.obs;

  final RxBool a = false.obs;

  setFromController(value) => baseController = value;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  setPage(value) => page.value = value;

  navigateToPage(int input) {
    if (controller.value.hasClients) {
      if(input == 1) postController.resetPostScreenList();
      if(input == 2) taskController.resetTaskScreenList();
      getController.animateToPage(input,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      setPage(input);
    }
  }
}
