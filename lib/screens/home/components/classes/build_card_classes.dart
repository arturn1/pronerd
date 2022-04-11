import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/class_controller.dart';
import '../../../../controller/post_controller.dart';
import '../../../../controller/task_controller.dart';
import '../../../../models/room.dart';
import '../../../../test.dart';
import '../../../../utils/constants.dart';
import '../../../class/class_screen.dart';

class ClassesCard extends StatelessWidget {
  const ClassesCard({Key? key, required this.uid, required this.roomModel})
      : super(key: key);

  final String uid;
  final RoomModel roomModel;

  @override
  Widget build(BuildContext context) {
    ClassController classController = Get.find();
    TaskController taskController = Get.find();
    PostController postController = Get.find();

    return InkWell(
      onTap: () => {
        postController.onClick(roomModel.classId),
        taskController.onClick(roomModel.classId),
          classController.getData(roomModel)
            .then((v) => Get.to(() => ClassFeed(roomModel: roomModel),
            // transition: Transition.rightToLeft
        ))
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: kPrimaryColorContainer90,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.supervisor_account_sharp,
                color: kOnPrimaryColorContainer10,
                size: 30,
              ),
            ),
            const SizedBox(height: 5),
            LimitedBox(
              //maxWidth: 45,
              child: AutoSizeText(
                roomModel.name,
                minFontSize: 4,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(fontFamily: 'myFont', fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
