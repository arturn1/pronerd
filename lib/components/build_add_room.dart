import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pronerd/components/build_btn.dart';

import '../controller/class_controller.dart';
import '../utils/constants.dart';

class CustomBottomSheetAddClass extends StatelessWidget {
  const CustomBottomSheetAddClass({ required this.message, Key? key}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
  final ClassController controller = Get.find();

    return SingleChildScrollView(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          color: kPrimarySurface,
          child: Form(
            //key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),)
                ,
                const SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(15),
                    ],
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (v) => controller.setName(v),
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    decoration: const InputDecoration(

                        labelText: 'Grupo',
                        hintMaxLines: 1,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green, width: 4.0))),
                  ),
                ),
                const SizedBox(
                  height:20
                ),
                CustomBtn(text: 'Salvar', function: () =>  controller.addClass().then((value) => Get.back()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
