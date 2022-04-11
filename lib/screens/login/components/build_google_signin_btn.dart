import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:pronerd/controller/auth_controller.dart';

import '../../../components/build_loading_page.dart';
import '../../../components/build_loading_page_login.dart';
import '../../base.dart';
import '../login_screen.dart';

class GoogleBtn extends StatelessWidget {
  const GoogleBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.find();

    return SizedBox(
        height: 45.0,
        width: double.infinity,
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            label: const Text(
              'Google',
              style: TextStyle(fontSize: 18.0),
            ),
            icon: const Icon(
              FontAwesomeIcons.google,
              size: 25.0,
            ),
            onPressed: () => Get.to(
                  () => CustomLoaderLogin(
                    getData: auth.signInWithGoogle(),
                    getBack: () => Get.to(() => const LoginScreen()),

                  ),
                )));
  }
}
