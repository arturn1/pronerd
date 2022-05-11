import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/screens/search/components/build_search_field.dart';
import 'package:pronerd/controller/auth_controller.dart';
import 'package:pronerd/controller/comment_controller.dart';
import 'package:pronerd/screens/class/class_screen.dart';
import 'package:pronerd/components/build_custom_appBar.dart';


import '../../components/build_header.dart';
import 'components/build_search_field.dart';
import 'controller/class_controller.dart';
import 'controller/date_picker_controller.dart';
import 'controller/post_controller.dart';
import 'controller/search_controller.dart';
import 'controller/task_controller.dart';
import 'models/room.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    SearchController searchController = Get.find();

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Material(
              elevation: 3,
              child: SizedBox(
                height: 60,
                child:
                Container(
                  color: Colors.white,
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: GestureDetector(
                            child: const Icon(Icons.arrow_back_rounded),
                            onTap: () => Get.back(),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: const CustomHeader(text: 'Grupos'))
                      ]),
                ),
              ),
            ),
            SearchField(),
            GetX<ClassController>(
              init: Get.put<ClassController>(ClassController()),
              builder: (ClassController classController) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: searchController.searchedRoomList.length,
                    itemBuilder: (_, index) =>
                        ClassesCard1(
                          roomModel: searchController.searchedRoomList[index],
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


class ClassesCard1 extends StatelessWidget {
  const ClassesCard1({Key? key, required this.roomModel})
      : super(key: key);

  final RoomModel roomModel;

  @override
  Widget build(BuildContext context) {

    DateController dateController = Get.find();

    ClassController classController = Get.find();
    TaskController taskController = Get.find();
    PostController postController = Get.find();

    return InkWell(
      onTap: () => {
        postController.onClick(roomModel.classId),
        taskController.onClick(roomModel.classId)
        // classController.getData(roomModel)
            .then((v) => Get.to(() => ClassFeed(roomModel: roomModel),
          // transition: Transition.rightToLeft
        ))
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF30A6FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                roomModel.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(fontFamily: 'myFont', fontSize: 12),
              ),
              Text(
                roomModel.userName,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(fontFamily: 'myFont', fontSize: 12),
              ),
              Text(
                dateController.showCorrectDate(roomModel.dateCreated),
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(fontFamily: 'myFont', fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

