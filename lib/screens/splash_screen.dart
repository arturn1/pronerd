import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/screens/base.dart';
import 'package:pronerd/utils/constants.dart';
import 'package:rive/rive.dart';

import '../controller/class_controller.dart';
import '../controller/drop_down_controller.dart';
import '../controller/task_controller.dart';
import 'login/login_screen.dart';

class AwesomeController extends GetxController {
  late Rx<User?> _user;

  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.offAll(
          () => const LoginScreen()
        );
      });
    } else {
      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.offAll(
          () => const BaseScreen()
        );
      });
    }
  }
}

class CustomSplashScreen extends StatelessWidget {
  const CustomSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: const RiveAnimation.asset(
              'assets/rive/1766-3488-projects-icon.riv')),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 150,
        padding: const EdgeInsets.all(20),
        child: const Center(
          child: Text(
            'PRO NERD',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
