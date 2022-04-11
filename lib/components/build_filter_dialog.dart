import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/components/build_btn.dart';

import '../controller/date_picker_controller.dart';
import '../controller/search_controller.dart';

class CustomFieldDialog {

  final SearchController controller = Get.find();

  buildDialog(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        color: Colors.white,
        child: Form(
          //key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                onChanged: (v) => controller.setSearch(v),
                keyboardType: TextInputType.text,
                maxLines: 1,
                decoration: const InputDecoration(
                    labelText: 'Grupo',
                    hintMaxLines: 1,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 4.0))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  readOnly: true,
                onTap: () => controller.presentDatePicker(context),
                controller: controller.textController,
                //initialValue: dateController.showDateNow(),
                keyboardType: TextInputType.none,
                maxLines: 1,
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: () => controller.presentDatePicker(context),
                      icon: const Icon(Icons.date_range),),
                    labelText: 'Data',
                    hintMaxLines: 1,
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 4.0))),
              ),
              const SizedBox(
                  height:20
              ),
              CustomBtn(text: 'Filtrar', function: () =>  Get.back())
            ],
          ),
        ),
      ),
    );
  }
}
