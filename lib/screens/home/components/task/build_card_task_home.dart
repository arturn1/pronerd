import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/models/task.dart';
import 'package:pronerd/utils/constants.dart';

import '../../../../controller/date_picker_controller.dart';
import '../../../../controller/task_controller.dart';

class NextDeliveriesCard extends StatelessWidget {
  const NextDeliveriesCard(
      {Key? key,
      required this.uid,
      required this.animationController,
      required this.animation,
      required this.taskModel})
      : super(key: key);

  final String uid;
  final TaskModel taskModel;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    DateController dateController = Get.find();
    TaskController taskController = Get.find();

    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, _) {
          return FadeTransition(
            opacity: animation,
            child: Transform(
              transform: Matrix4.translationValues(
                  100 * (1.0 - animation.value), 0.0, 0.0),
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                  width: Get.width*.944,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      Container(
                        color: kPrimaryColorContainer90,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: AutoSizeText(
                                taskModel.className,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: kOnPrimaryColorContainer10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            AutoSizeText(
                              taskModel.description,
                              minFontSize: 4,
                              style: (TextStyle(
                                color: kOnPrimaryColorContainer10,
                                fontSize: pixelDevice == 3 ? Theme.of(context).textTheme.labelMedium?.fontSize :
                                  Theme.of(context).textTheme.labelLarge?.fontSize
                              )),
                              maxLines: 2,
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: AutoSizeText(
                                dateController.getDate(taskModel),
                                style: TextStyle(
                                  color: kOnPrimaryColorContainer10,
                                    fontSize: pixelDevice == 3 ? Theme.of(context).textTheme.labelSmall?.fontSize :
                                    Theme.of(context).textTheme.labelMedium?.fontSize
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
