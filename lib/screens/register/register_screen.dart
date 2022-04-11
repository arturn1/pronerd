import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pronerd/components/build_btn.dart';
import 'package:pronerd/components/build_input_form.dart';
import 'package:pronerd/components/build_logo.dart';
import 'package:pronerd/controller/auth_controller.dart';
import 'package:pronerd/utils/constants.dart';
import 'package:rive/rive.dart';

import '../../components/build_loading_page.dart';
import '../../components/build_loading_page_login.dart';
import '../base.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = "/register";

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.find();

    return Scaffold(
      //bottomSheet: const Footer(),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60.0, bottom: 20),
                child: BuildCustomLogoImg(),
              ),
              Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.white,
                  child: const RiveAnimation.asset(
                      'assets/rive/1542-3018-party.riv')),
              Padding(
                padding: const EdgeInsets.all(kPaddingDefault),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomFormInput(
                        icon: Icons.person,
                        title: 'Nome',
                        controller: (v) => auth.setNewName(v),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (v) => auth.getNameError(v),
                      ),
                      const SizedBox(height: 5.0),
                      CustomFormInput(
                        icon: Icons.email,
                        title: 'Insira seu e-mail',
                        controller: (v) => auth.setNewEmail(v),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (v) => auth.getEmailError(v),
                      ),
                      const SizedBox(height: 5.0),
                      CustomFormInput(
                        locked: true,
                        icon: Icons.lock,
                        title: 'Insira sua nova senha',
                        controller: (v) => auth.setNewPassword(v),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (v) => auth.getPasswordError(v),
                      ),
                      const SizedBox(height: 05),
                      CustomFormInput(
                        locked: true,
                        icon: Icons.lock,
                        title: 'Repita sua senha',
                        controller: (v) => auth.setNewConfirmedPassword(v),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (v) => auth.getConfirmPasswordError(v),
                      ),
                      const SizedBox(height: 80),
                      Obx(() =>  CustomBtn(
                          text: 'Registrar',
                          function: auth.enableRegisterButton()
                              ? () => Get.to(() => CustomLoaderLogin(
                                    getData: auth.registerUser(),
                            getBack: () => Get.to(() => const LoginScreen()),
                                  ))
                              : () => auth.doNothing(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
