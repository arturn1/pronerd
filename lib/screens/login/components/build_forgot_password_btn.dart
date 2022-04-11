import 'package:flutter/material.dart';
import 'package:pronerd/utils/constants.dart';

class BuildForgotPassBtn extends StatelessWidget {
  const BuildForgotPassBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      alignment: Alignment.centerRight,
      child: OutlinedButton(
        onPressed: () => {},
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        child: const Text(
          'Esqueci a senha',
          style: kLabelStyle,
        ),
      ),
    );
  }
}
