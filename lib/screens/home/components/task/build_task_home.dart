import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:pronerd/controller/auth_controller.dart';
import 'package:pronerd/controller/task_controller.dart';

import '../../../../controller/user_controller.dart';
import '../../../../models/task.dart';
import '../../../../utils/constants.dart';
import 'build_card_task_home.dart';

class BuildTaskHome extends StatefulWidget {
  const BuildTaskHome({Key? key}) : super(key: key);

  @override
  State<BuildTaskHome> createState() => _BuildTaskHomeState();
}

class _BuildTaskHomeState extends State<BuildTaskHome>
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
    TaskController taskController = Get.find();
    UserController userController = Get.find();


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
          StreamBuilder<List<TaskModel>>(
              stream: taskController.taskListByClassFromUser.stream,
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  if (!snapshot.hasData) {
                    taskController.taskListByClassFromUser
                        .bindStream(taskController.taskStreamByClassFromUser());
                  }
                  return const Center(
                    child: GFLoader(
                      type: GFLoaderType.android,
                    ),
                  );
                }

                if (snapshot.data!.isEmpty) {
                  return const Center(child: Text("Sem entregas pendentes"));
                }

                if (snapshot.hasData) {
                  return SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) {
                            const int count = 1;
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

                            return SizedBox(
                              width: kWidthDefault,
                              height: 100,
                              child: PageView.builder(
                                  itemCount: snapshot.data!.length,
                                  pageSnapping: true,
                                  itemBuilder: (context, index) {
                                    return NextDeliveriesCard(
                                        uid: userController.userModel!.uid,
                                        animation: animation,
                                        animationController:
                                            animationController,
                                        taskModel: snapshot.data![index]);
                                  }),
                            );
                          }));
                }
                return Container(
                  height: 50,
                  color: Colors.yellow,
                );
              })
        ],
      ),
    );
  }
}
