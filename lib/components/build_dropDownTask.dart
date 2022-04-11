import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/task_controller.dart';
import '../controller/drop_down_controller.dart';
import '../models/room.dart';
import '../utils/constants.dart';

class CustomDropDownCreateTask extends GetView<DropDownController> {
  const CustomDropDownCreateTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.find();

    return GetBuilder<DropDownController>(builder: (controller) {
      return DropdownButtonHideUnderline(
          child: Container(
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey, // red as border color
            ),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: DropdownButton(
            isExpanded: true,
            isDense: true,
            // Reduces the dropdowns height by +/- 50%
            icon: const Icon(Icons.keyboard_arrow_down),
            hint: Container(
                padding: const EdgeInsets.only(left: 10),
                child: Obx(() => taskController.className == '' ? const Text("Selecione um grupo") : Text(taskController.className))),
            items: controller.classes.map((RoomModel item) {
              return DropdownMenuItem(
                value: item.classId,
                child: Text(item.name),
                onTap:  () => taskController.set(item.name, item.classId),
              );
            }).toList(),
            onChanged: (v) {
              // taskController.setClassId(v.toString());
              // print(taskController.classId);
            }
            ),
      ));
    });
  }
}
