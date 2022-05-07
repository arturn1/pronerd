import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/screens/login/login_screen.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pronerd/utils/constants.dart';

import '../controller/auth_controller.dart';
import '../controller/class_controller.dart';
import '../controller/drop_down_controller.dart';
import 'build_snack_bar.dart';

class CustomLoaderLogin extends StatelessWidget {
  const CustomLoaderLogin({
    Key? key,
    required this.getData,
    required this.getBack,
  }) : super(key: key);

  final Future getData;
  final Function getBack;

  @override
  Widget build(BuildContext context) {

    return Container(
        color: Colors.white,
        child: FutureBuilder(
            future: getData,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {}
              if (snapshot.hasError) {
                Future.delayed(Duration.zero, () async {
                  getBack();
                });
              }
              return Container(
                color: kPrimaryBarColor,
                child: const Center(
                  child: GFLoader(type: GFLoaderType.ios),
                ),
              );
            }));
  }
}
