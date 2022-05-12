import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/controller/drop_down_controller.dart';

class PageNavigationController extends GetxController {
  DropDownController dropdown = Get.put(DropDownController());

  final RxInt page = 0.obs;
  Rx<PageController> controller = PageController(initialPage: 0).obs;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  setPage(value) => page.value = value;

  navigateToPage(int input) async {
    if (controller.value.hasClients) {
      controller.value.animateToPage(input,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      setPage(input);
    }
  }
}
