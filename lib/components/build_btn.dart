import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pronerd/utils/constants.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    Key? key,
    required this.text,
    required this.function,
  }) : super(key: key);

  final String text;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            primary: kPrimaryColor40,
          ),
          onPressed: () => function(),
          child: Text(text,
              style: TextStyle(
                color: kOnPrimaryColor100,
                letterSpacing: 0.8,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              )),
        ));
  }
}
