import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/controller/image_controller.dart';

import '../utils/constants.dart';
import 'build_add_task.dart';

class SelectImageSourceSnack extends StatelessWidget {
  const SelectImageSourceSnack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImageController imageController = Get.find();

    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: Container(
        constraints: BoxConstraints(
            minHeight: Get.height * .2, maxHeight: Get.height * .30),
        color: kPrimarySurface,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 25, 8, 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Criar nova',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(padding: EdgeInsets.only(left: 40)),
                  buildBtn('Galeria', Icons.add_photo_alternate,
                      () => imageController.getFromCamera(context, 'gallery')),
                  const Spacer(),
                  buildBtn('Câmera', Icons.add_a_photo,
                      () => imageController.getFromCamera(context, 'camera')),
                  const Spacer(),
                  buildBtn(
                    'Tarefa',
                    Icons.edit,
                    () => Get.bottomSheet(
                        CustomModal().buildModal('Nova Tarefa', context)),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 40)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildBtn(String title, IconData icon, VoidCallback onTap) {
  return GestureDetector(
    onTap: () => onTap(),
    child: Column(
      children: [
        CircleAvatar(
          radius: 35,
          child: Icon(
            icon,
            size: 30,
            color: kOnPrimaryColorContainer10,
          ),
          backgroundColor: kPrimaryColorContainer90,
        ),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
