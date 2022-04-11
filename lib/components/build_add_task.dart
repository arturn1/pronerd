import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pronerd/components/build_dropDownTask.dart';
import 'package:pronerd/components/build_btn.dart';
import 'package:pronerd/controller/date_picker_controller.dart';
import 'package:pronerd/controller/task_controller.dart';

import '../controller/post_controller.dart';
import '../controller/task_controller.dart';
import '../utils/constants.dart';
import 'build_snack_bar.dart';

class CustomModal {
  final TaskController controller = Get.find();
  final DateController dateController = Get.find();
  PostController postController = Get.find();

  buildModal(String message, BuildContext context) {
    return SingleChildScrollView(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          color: kPrimarySurface,
          child: Form(
            //key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 20,
                    color: kOnPrimaryColorContainer10
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const CustomDropDownCreateTask(),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 60,
                  child: TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(140),
                    ],
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (v) => controller.setDescription(v),
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        labelText: 'Descrição',
                        //hintMaxLines: 1,
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 4.0))),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    onTap: () => dateController.presentDatePicker(context),
                    controller: dateController.textController,
                    //initialValue: dateController.showDateNow(),
                    keyboardType: TextInputType.datetime,
                    maxLines: 1,
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () =>
                              dateController.presentDatePicker(context),
                          icon: const Icon(Icons.date_range),
                        ),
                        labelText: 'Data de Entrega',
                        hintMaxLines: 1,
                        border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 4.0))),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                CustomBtn(
                    text: 'Salvar',
                    function: () => controller.className.isNotEmpty ?
                        controller.addTask().then((value) => Get.back()) :
                    CustomSnack().buildCardError('Selecione um grupo'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
