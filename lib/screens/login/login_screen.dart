import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pronerd/components/build_divider.dart';
import 'package:pronerd/components/build_loading_page.dart';
import 'package:pronerd/components/build_logo.dart';
import 'package:pronerd/components/build_input_form.dart';
import 'package:pronerd/controller/auth_controller.dart';
import 'package:pronerd/screens/base.dart';
import 'package:pronerd/screens/register/register_screen.dart';
import 'package:pronerd/utils/constants.dart';

import '../../components/build_loading_page_login.dart';
import '../../controller/class_controller.dart';
import 'components/build_forgot_password_btn.dart';
import 'components/build_google_signin_btn.dart';
import '../../components/build_btn.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.put(AuthController());
    //ClassController classController = Get.put(ClassController());

    return Scaffold(
      //bottomSheet: const Footer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kPaddingDefault),
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 50.0, bottom: 20),
                  child: BuildCustomLogoImg(),
                ),
                const SizedBox(height: 60.0),
                Form(
                  child: CustomFormInput(
                    icon: Icons.email,
                    title: 'Insira seu e-mail',
                    controller: (v) => auth.setEmail(v),
                    validator: (value) => auth.getEmailError(value),
                  ),
                ),
                const SizedBox(height: 10.0),
                CustomFormInput(
                  icon: Icons.lock,
                  title: 'Insira sua senha',
                  locked: true,
                  controller: (v) => auth.setPassword(v),
                  validator: (value) => auth.getEmptyError(value),
                ),
                const BuildForgotPassBtn(),
                const SizedBox(height: 40.0),
                Obx(() => CustomBtn(
                    text: 'Acessar',
                    function: auth.enableButton() ? () => Get.to(() => CustomLoaderLogin(
                        getData: auth.loginUser(),
                      getBack: () => Get.to(() => const LoginScreen()),

                    )) : () => auth.doNothing(),
                  ),
                ),
                const SizedBox(height: 30.0),
                const GoogleBtn(),
                const SizedBox(height: 20.0),
                const CustomDivider(),
                const SizedBox(height: 20.0),
                CustomBtn(
                  text: 'Criar conta',
                  function: () => {
                    (Get.to(
                      () => const RegisterScreen(),
                    ))
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


