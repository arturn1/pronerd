import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/models/task.dart';

import '../../../controller/date_picker_controller.dart';
import '../../../controller/task_controller.dart';
import '../../../utils/constants.dart';

class TaskCard extends StatelessWidget {
  final TaskModel taskModel;

  const TaskCard({Key? key, required this.taskModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    DateController dateController = Get.find();

    return Container(
      padding: const EdgeInsets.all(kPaddingExternalDefault / 2),
      child: Container(
        decoration: BoxDecoration(
            color: kPrimaryColorContainer90,
            borderRadius: BorderRadius.circular(kBorderDefault)),
        padding: const EdgeInsets.all(kPaddingDefault / 1.3),
        height: kHeightDefault * 0.25,
        width: kWidthDefault,
        child: Row(
          children: [
            FittedBox(
              child: Container(
                constraints: BoxConstraints.tightFor(
                    width: Get.width * 0.25),
                margin: const EdgeInsets.only(right: kMarginDefault),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Faltam',
                      style: TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize),
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        dateController.getOnlyDate(taskModel),
                        style: TextStyle(
                           fontSize: Theme.of(context).textTheme.headline1?.fontSize,
                          //fontSize: 23,
                          color: kOnPrimaryColorContainer10,
                        ),
                      ),
                    ),
                    Text('dias',
                      style: TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize),
                    ),
                    Text(
                      dateController.showCorrectDate(taskModel.finalDate),
                      style: TextStyle(fontSize: Theme.of(context).textTheme.labelSmall?.fontSize),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(kPaddingDefault / 3),
                  margin: const EdgeInsets.only(bottom: kMarginDefault / 2),
                  decoration: BoxDecoration(
                      color: kOnSecondaryColorContainer10,
                      borderRadius: BorderRadius.circular(kBorderDefault)),
                  alignment: Alignment.center,
                  child: Text(
                    taskModel.className,
                    style: TextStyle(
                        fontSize: Theme.of(context).textTheme.labelLarge?.fontSize, color: kSecondaryColorContainer90),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: kTertiaryColorContainer90,
                        borderRadius: BorderRadius.circular(kBorderDefault)),
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(kPaddingDefault/2),
                      child: AutoSizeText(taskModel.description),
                    ),
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
