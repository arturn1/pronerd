import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pronerd/components/build_header.dart';
import 'package:pronerd/controller/auth_controller.dart';
import 'package:pronerd/controller/search_controller.dart';
import 'package:pronerd/controller/task_controller.dart';
import 'package:pronerd/controller/user_controller.dart';

import '../../components/build_filter_dialog.dart';
import '../../components/build_search_field.dart';
import '../../models/task.dart';
import '../../utils/constants.dart';
import 'components/build_custom_header_task_screen.dart';
import 'components/build_screen_task_card.dart';
import 'components/build_search_field.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchController searchController = Get.put(SearchController());
    final TaskController taskController = Get.find();
    final UserController userController = Get.find();

    return Scaffold(
      body: Column(
        children: [
          Obx(
            () => AnimatedCrossFade(
              duration: const Duration(milliseconds: 500),
              sizeCurve: Curves.easeIn,
              crossFadeState: searchController.isSearching.isFalse
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild:
                  const Center(child: CustomHeaderTaskScreen(text: 'Entregas')),
              secondChild: Container(
                  color: kPrimaryBarColor,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: kMarginDefault,
                        vertical: kMarginDefault / 4),
                    height: 50,
                    child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(15),
                        ],
                        onChanged: (v) => {
                              taskController.runFilter(v),
                            },
                        cursorColor: Colors.black,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.lightBlue, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 2.0),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              //borderSide: BorderSide.none,
                            ),
                            //prefixIcon: const Icon(Icons.search, color: Colors.black54),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.cancel_rounded,
                                  color: Colors.black54),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                searchController.reset();
                                searchController.setIsSearching(false);
                              },
                            ),
                            hintText: 'Pesquisar ...',
                            hintStyle: const TextStyle(color: Colors.black26))),
                  )),
            ),
          ),
          Expanded(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              //color: kPrimaryBarColor,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault),
              child: Row(
                children: [
                  Obx(
                    () => Text(taskController.filteredTaskList.value.length
                            .toString() +
                        ' posts encontrados'),
                  ),
                ],
              ),
            ),
            GetX<TaskController>(
                init: Get.put<TaskController>(TaskController()),
                builder: (TaskController taskController) {
                  if (taskController.filteredTaskList.value.isEmpty) {
                    return Container(
                        padding: const EdgeInsets.all(kPaddingDefault * 2),
                        child: Column(
                          children: const [
                            Text("Não há entregas pendentes"),
                            Padding(
                              padding: EdgeInsets.all(kPaddingDefault * 2),
                              child: Center(
                                  child: Icon(
                                FontAwesomeIcons.listCheck,
                                size: 50,
                              )),
                            )
                          ],
                        ));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            taskController.filteredTaskList.value.length,
                        itemBuilder: (_, index) {
                          return Slidable(
                            key: UniqueKey(),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              dismissible: DismissiblePane(onDismissed: () {
                                taskController.deleteTask(taskController
                                    .filteredTaskList.value[index].taskId);
                              }),
                              children: [
                                SlidableAction(
                                  onPressed: (_) => taskController.deleteTask(
                                      taskController
                                          .filteredTaskList.value[index]
                                          .taskId),
                                  backgroundColor: kSuccessColor40,
                                  foregroundColor: kSuccessColorContainer90,
                                  icon: Icons.check,
                                  label: 'Entregue',
                                ),
                                // SlidableAction(
                                //   onPressed: doNothing,
                                //   backgroundColor: kTertiaryColorContainer90,
                                //   foregroundColor: kOnTertiaryColorContainer10,
                                //   icon: Icons.edit,
                                //   label: 'Editar',
                                // ),
                              ],
                            ),
                            child: TaskCard(
                                taskModel: taskController
                                    .filteredTaskList.value[index]),
                          );
                        },
                      ),
                    );
                  }
                })
          ])),
        ],
      ),
    );
  }
}

void doNothing(BuildContext context) {
  print('apetado');
}
