import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/controller/auth_controller.dart';
import 'package:pronerd/utils/constants.dart';

class CustomFormInput extends StatelessWidget {

  final AuthController auth = Get.find();

  CustomFormInput({
    Key? key,
    required this.controller,
    required this.icon,
    required this.title,
    this.locked = false,
    required this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : super(key: key);

  final Function(String) controller;
  final IconData icon;
  final String title;
  final bool locked;
  final AutovalidateMode autovalidateMode;
  final FormFieldValidator validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextFormField(
            validator: validator,
            autovalidateMode: autovalidateMode,
            obscureText: locked,
            autofocus: false,
            cursorColor: Colors.grey,
            onChanged: controller,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.grey,
            ),
            decoration: InputDecoration(
              //border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.only(top: 18.0),
              prefixIcon: Icon(icon),
              hintText: title,
              hintStyle:const TextStyle(
                color: Colors.grey,
              )
            ),
          ),
        ),
      ],
    );
  }
}
