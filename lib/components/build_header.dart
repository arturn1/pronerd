import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryBarColor,
      alignment: Alignment.center,
      height: 60,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 25,
          letterSpacing: .01,
          color: kOnPrimaryColorContainer10,
          fontWeight: FontWeight.bold,
          fontFamily: 'myFont',
        ),
      ),
    );
  }
}
