import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../controller/page_controller.dart';
import '../utils/constants.dart';

class AnimatedBottomDrawer extends StatefulWidget {
  const AnimatedBottomDrawer({Key? key}) : super(key: key);

  @override
  State<AnimatedBottomDrawer> createState() => _AnimatedBottomDrawer();
}

class _AnimatedBottomDrawer extends State<AnimatedBottomDrawer> {
  final PageNavigationController pageController = Get.find();
  final AuthController auth = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //bottom: false,
      child: Obx(
        () => SizedBox(
          height: pixelDevice == 3 ? 88 : 82,
          child: BottomNavigationBar(
            showUnselectedLabels: false,
            enableFeedback: false,
            showSelectedLabels: false,
            selectedLabelStyle: const TextStyle(
              fontSize: 14,
            ),
            unselectedIconTheme: const IconThemeData(size: 20),
            backgroundColor: kPrimaryBarColor,
            currentIndex: pageController.page.value,
            onTap: pageController.navigateToPage,

            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                activeIcon: Column(
                  children: [
                    Container(
                      width: 55,
                      height: 31,
                      decoration: BoxDecoration(
                          color: kPrimaryColorEx,
                          borderRadius: BorderRadius.circular(15)),
                      child: Icon(
                        FontAwesomeIcons.house,
                        color: kOnPrimaryColorContainer10,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('Home')
                  ],
                ),
                icon: const Icon(FontAwesomeIcons.house,
                size: 25,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 0),
                      width: 55,
                      height: 31,
                      decoration: BoxDecoration(
                          color: kPrimaryColorEx,
                          borderRadius: BorderRadius.circular(15)),
                      child: Icon(
                        FontAwesomeIcons.images,
                        color: kOnPrimaryColorContainer10,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('Posts')
                  ],
                ),
                icon: const Icon(FontAwesomeIcons.images,
                size: 25,),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 0),
                      width: 55,
                      height: 31,
                      decoration: BoxDecoration(
                          color: kPrimaryColorEx,
                          borderRadius: BorderRadius.circular(15)),
                      child: Icon(
                        FontAwesomeIcons.pencil,
                        color: kOnPrimaryColorContainer10,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('Tarefas')
                  ],
                ),
                icon: const Icon(FontAwesomeIcons.pencil,
                  size: 25,),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
