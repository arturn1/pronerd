import 'package:flutter/material.dart';

class BuildCustomLogoImg extends StatelessWidget {
  const BuildCustomLogoImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 200,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: const Color(0xFFcfcfcf),
          ),
          borderRadius: BorderRadius.circular(7)
        ),
        alignment: Alignment.center,
        child: const Text("PRO NERD",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
          ),
        ),
      ),
    );
  }
}
