import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/screens/search/components/build_search_field.dart';
import 'package:pronerd/controller/auth_controller.dart';
import 'package:pronerd/controller/comment_controller.dart';
import 'package:pronerd/screens/class/class_screen.dart';
import 'package:pronerd/components/build_custom_appBar.dart';
import 'package:pronerd/screens/search/components/class_card.dart';


import '../../components/build_header.dart';
import '../../controller/class_controller.dart';
import '../../controller/search_controller.dart';
import '../../models/room.dart';
import '../../utils/constants.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    SearchController searchController = Get.put(SearchController());

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Container(
          color: kPrimarySurface,
          child: Column(
            children: [
              Container(
                height: 60,
                color: kPrimaryBarColor,
                child:
                Row(crossAxisAlignment: CrossAxisAlignment.center,
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
              Container(color: kPrimaryBarColor, child: SearchRoomField()),
              GetX<ClassController>(
                init: Get.put<ClassController>(ClassController()),
                builder: (ClassController classController) {
                  return Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 1.0,
                      ),
                      itemCount: searchController.searchedRoomList.length,
                      itemBuilder: (_, index) =>
                          ClassesCard(
                            roomModel: searchController.searchedRoomList[index],
                          ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

