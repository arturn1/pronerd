import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:pronerd/screens/login/login_screen.dart';

import '../controller/auth_controller.dart';
import '../controller/class_controller.dart';
import '../controller/drop_down_controller.dart';
import 'build_snack_bar.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader(
      {Key? key,
      required this.getData,
      required this.getBack,
      required this.getTo})
      : super(key: key);

  final Future getData;
  final Function getTo;
  final Function getBack;

  @override
  Widget build(BuildContext context) {
    AuthController auth = Get.find();
    DropDownController dropDownController = Get.put(DropDownController());
    ClassController classController = Get.put(ClassController());

    return Container(
        color: Colors.white,
        child: FutureBuilder(
          future: getData,
          builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                   Future.delayed(Duration.zero, () async {
                    getTo();
                   });
                }
                if (snapshot.hasError) {
                  Future.delayed(Duration.zero, () async {
                    getBack();
                     print('hasError');
                  });
                }
            return const Center(
              child: GFLoader(
                type: GFLoaderType.custom,
                loaderIconOne   : Icon(Icons.upload_file, size: 50)
              ),
            );
          },
        ));
  }
}
