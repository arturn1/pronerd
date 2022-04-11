import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../controller/search_controller.dart';
import '../../../utils/constants.dart';


class CustomHeaderTaskScreen extends StatelessWidget {
  const CustomHeaderTaskScreen({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final SearchController searchController = Get.find();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      color: kPrimaryBarColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 25,
              letterSpacing: .01,
              color: kOnPrimaryColorContainer10,
              fontWeight: FontWeight.bold,
              fontFamily: 'myFont',
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              searchController.setIsSearching(true);
            },
          )
        ],
      ),
    );
  }
}
