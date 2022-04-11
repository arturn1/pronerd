import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pronerd/controller/auth_controller.dart';
import 'package:pronerd/controller/task_controller.dart';

import '../../../../models/task.dart';
import '../../../../utils/constants.dart';
import 'build_card_task_home.dart';

class BuildTaskHome extends StatefulWidget {
  const BuildTaskHome({Key? key}) : super(key: key);

  @override
  State<BuildTaskHome> createState() => _BuildTaskHomeState();
}

class _BuildTaskHomeState extends State<BuildTaskHome> with TickerProviderStateMixin {

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
      height: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Icon(
                //   FontAwesomeIcons.caretLeft,
                //   size: 20,
                //   color: kOnPrimaryColorContainer10,
                // ),
                const Text(
                  'Próximas entregas',
                  style: kLabelHeadStyle,
                ),
                Icon(
                 FontAwesomeIcons.caretRight,
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
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount:
                    taskController.taskListByClassFromUser.isEmpty
                        ? 1
                        : taskController.taskListByClassFromUser.length,
                    itemBuilder: (_, index) {

                      final int count = taskController.taskListByClassFromUser.isEmpty ?
                          1 :taskController.taskListByClassFromUser.length;

                      final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController,
                              curve:
                              Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn,
                              )));

                      animationController.forward();


                      return taskController.taskListByClassFromUser.isEmpty
                          ? NextDeliveriesCard(
                              uid: '0',
                          animation: animation,
                          animationController: animationController,
                          taskModel: TaskModel(

                                  finalDate: DateTime.now(),
                                  description:
                                      'Seja bem vindo!',
                              taskId: '',
                                  classId: '', className: 'Novo por aqui?!'))
                          :
                      // NextDeliveriesCard(
                      //         uid: auth.user.uid,
                      //     animation: animation,
                      //     animationController: animationController,
                      //     taskModel:
                      //             taskController.taskListByClassFromUser.value[index])
                      SizedBox(
                        width: kWidthDefault,
                        height: 100,
                        child: PageView.builder(
                            itemCount: taskController.taskListByClassFromUser.length,
                            pageSnapping: true,
                            itemBuilder: (context,index){
                              return NextDeliveriesCard(
                                  uid: auth.user.uid,
                              animation: animation,
                              animationController: animationController,
                              taskModel:
                                      taskController.taskListByClassFromUser[index]);}),
                      )
                      ;
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
