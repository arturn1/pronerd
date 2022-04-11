import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../controller/page_controller.dart';
import '../../utils/constants.dart';
import 'build_animated_bottom_bar.dart';

class CustomBottomNavigationBar extends GetView<PageNavigationController> {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageNavigationController pageController =
    Get.find();
    final AuthController auth = Get.find();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: 75,
      child: Obx(
        () => CustomAnimatedBottomBar(
          containerHeight: 0,
          backgroundColor: kPrimaryBarColor,
          selectedIndex: pageController.page.value,
          showElevation: true,
          itemCornerRadius: 15,
          curve: Curves.easeIn,
          onItemSelected: (index) => pageController.navigateToPage(index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: const Icon(Icons.apps),
              title: const Text('Home'),
              activeColor: kPrimaryColor40,
              inactiveColor: kOnPrimaryColorContainer10,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(FontAwesomeIcons.image),
              title: const Text('Posts'),
              activeColor: kPrimaryColor40,
              inactiveColor: kOnPrimaryColorContainer10,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.edit),
              title: const Text('Entregas'),
              activeColor: kPrimaryColor40,
              inactiveColor: kOnPrimaryColorContainer10,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
