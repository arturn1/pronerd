import 'package:flutter/material.dart';

import '../../components/build_search_field.dart';
import '../../utils/constants.dart';
import 'components/classes/build_classes.dart';
import 'components/post/build_feed.dart';
import 'components/task/build_task_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
