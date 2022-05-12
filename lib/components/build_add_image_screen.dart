import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pronerd/components/build_btn.dart';
import 'package:pronerd/components/build_dropDownTask.dart';
import 'package:pronerd/components/build_header.dart';
import 'package:pronerd/components/build_input_form.dart';
import 'package:pronerd/components/build_snack_bar.dart';
import 'package:pronerd/controller/post_controller.dart';
import 'package:pronerd/utils/constants.dart';

import '../screens/base.dart';
import '../screens/login/login_screen.dart';
import 'build_dropDownPost.dart';
import 'build_loading_page.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({
    Key? key,
    required this.imagePath,
    required BuildContext context,
  }) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.find();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Material(elevation: 3, child: CustomHeader(text: 'Postar')),
              Container(
                padding: const EdgeInsets.all(kPaddingDefault),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(imagePath),
                            height: Get.height * .5,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomDropDownCreatePost(),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(40),
                          ],
                          textCapitalization: TextCapitalization.sentences,
                          onChanged: (v) => postController.setDescription(v),
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              labelText: 'Descrição',
                              hintMaxLines: 1,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 4.0))),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomBtn(
                        text: 'Salvar',
                        function: () => postController.className.isNotEmpty
                            ? {
                                Get.to(() => CustomLoader(
                                    getData:
                                        postController.addPost(File(imagePath)),
                                    getBack: () =>
                                        Get.offAll(const BaseScreen()),
                                    getTo: () =>
                                        Get.offAll(() => const BaseScreen()))),
                                Future.delayed(
                                    const Duration(milliseconds: 3000),
                                    () async {
                                  CustomSnack().buildCardSuccess(
                                      'Post salvo com sucesso');
                                })
                              }
                            : CustomSnack()
                                .buildCardError('Selecione um grupo'),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
