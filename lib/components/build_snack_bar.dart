import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class CustomSnack {
  buildCardError(String? message) {
    Get.snackbar(
      "Por favor",
      message!,
      icon: const Icon(Icons.warning, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: kErrorColor40,
      snackStyle: SnackStyle.FLOATING,
      colorText: kOnErrorColor100,
      isDismissible: true,
      dismissDirection: DismissDirection.vertical,
      shouldIconPulse: true,
        padding: const EdgeInsets.symmetric(vertical: kPaddingDefault, horizontal: kPaddingDefault*3),
        margin: const EdgeInsets.symmetric(vertical: kMarginDefault, horizontal: kMarginDefault)
    );
  }

  buildCardSuccess(String message) {
    Get.snackbar(
      "Parabéns",
      message,
      icon:
          Icon(Icons.assignment_turned_in_outlined, color: kSuccessColorContainer10),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: kSuccessColorContainer90,
      snackStyle: SnackStyle.FLOATING,
      colorText: kOnTertiaryColorContainer10,
        padding: const EdgeInsets.symmetric(vertical: kPaddingDefault, horizontal: kPaddingDefault*3),
        margin: const EdgeInsets.symmetric(vertical: kMarginDefault, horizontal: kMarginDefault)

    );
  }

  buildCardInformation(String message) {
    Get.snackbar(
      "Vá com calma",
      message,
      icon:
      Icon(FontAwesomeIcons.houseMedical, color: kOnPrimaryColorContainer10),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: kInfoColor,
      snackStyle: SnackStyle.FLOATING,
      colorText: kSuccessColorContainer10,
      duration: const Duration(seconds: 5),
      padding: const EdgeInsets.symmetric(vertical: kPaddingDefault, horizontal: kPaddingDefault*2),
      margin: const EdgeInsets.symmetric(vertical: kMarginDefault, horizontal: kMarginDefault)
    );
  }
}
