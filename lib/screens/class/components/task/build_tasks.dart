import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/controller/auth_controller.dart';
import 'package:pronerd/controller/task_controller.dart';

import '../../../../../models/task.dart';
import '../../../../utils/constants.dart';
import '../../../home/components/task/build_card_task_home.dart';
import 'build_task_card_class.dart';

class BuildClassTasks extends StatefulWidget {
  const BuildClassTasks({Key? key}) : super(key: key);

  @override
  State<BuildClassTasks> createState() => _BuildClassTasksState();
}

class _BuildClassTasksState extends State<BuildClassTasks>
    with TickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthController auth = Get.find();

    return SizedBox(
      height: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20.0, bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Row(
              children: [
                Text(
                  'Entregas',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kOnPrimaryColorContainer10),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_right,
                  size: 20,
                  color: kOnPrimaryColorContainer10,
                )
              ],
            ),
          ),
          GetX<TaskController>(
              init: Get.put<TaskController>(TaskController()),
              builder: (TaskController taskController) {
                return SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: taskController.taskListByClass.value.isEmpty
                        ? 1
                        : taskController.taskListByClass.value.length,
                    itemBuilder: (_, index) {
                      final int count =
                      taskController.taskListByClass.value.isEmpty
                              ? 1
                              : taskController.taskListByClass.value.length;

                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0)
                              .animate(CurvedAnimation(
                                  parent: animationController,
                                  curve: Interval(
                                    (1 / count) * index,
                                    1.0,
                                    curve: Curves.fastOutSlowIn,
                                  )));
                      animationController.forward();
                      return taskController.taskListByClass.value.isEmpty
                          ? NextDeliveriesCardClass(
                              uid: '0',
                              taskModel: TaskModel(
                                  finalDate: DateTime.now(),
                                  description:
                                      'Seja bem vindo',
                                  taskId: '',
                                  classId: '',
                                  className: 'Novo por aqui?!'),
                              animation: animation,
                              animationController: animationController,
                            )
                          : NextDeliveriesCardClass(
                              uid: auth.user.uid,
                              taskModel:
                              taskController.taskListByClass.value[index],
                              animation: animation,
                              animationController: animationController,
                            );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
