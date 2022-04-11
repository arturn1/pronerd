import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/task_controller.dart';
import 'components/classes/build_classes.dart';
import 'components/post/build_feed.dart';
import 'components/task/build_task_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future onPageCalled(GetPage page) {
    final taskController = Get.find<TaskController>();
    return taskController.updateHome();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: const [
            // const SearchField(),
            BuildClassHome(),
            BuildTaskHome(),
            BuildFeedHome(),
            //const MyBuildFeed(),
          ],
        ),
      ),
    );
  }
}
