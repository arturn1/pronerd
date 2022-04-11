import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const kLabelStyle = TextStyle(
  color: Colors.grey,
);

const kLabelHeadStyle = TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.bold,
    fontFamily: 'myFont',
    color: Colors.black87);

Color kPrimaryInputColor = const Color.fromRGBO(245, 246, 249, 1);

Color kPrimarySurface = const Color.fromRGBO(245, 249, 252, 1);

Color kPrimaryBarColor = const Color.fromRGBO(234, 242, 247, 1);

Color kPrimaryColorEx = const Color.fromRGBO(161, 199, 231, 1);
Color kPrimaryColor40 = const Color.fromRGBO(84, 154, 211, 1);
Color kOnPrimaryColor100 = const Color.fromRGBO(255, 255, 255, 1);
Color kPrimaryColorContainer90 = const Color.fromRGBO(205, 229, 255, 1);
Color kOnPrimaryColorContainer10 = const Color.fromRGBO(18, 46, 69, 1);

Color kSecondaryColorEx = const Color.fromRGBO(231, 161, 200, 1);
Color kSecondaryColor40 = const Color.fromRGBO(211, 84, 154, 1);
Color kOnSecondaryColor100 = const Color.fromRGBO(255, 255, 255, 1);
Color kSecondaryColorContainer90 = const Color.fromRGBO(249, 232, 241, 1);
Color kOnSecondaryColorContainer10 = const Color.fromRGBO(139, 36, 92, 1);

Color kTertiaryColorEx = const Color.fromRGBO(200, 231, 161, 1);
Color kTertiaryColor40 = const Color.fromRGBO(214, 237, 185, 1);
Color kOnTertiaryColor100 = const Color.fromRGBO(255, 255, 255, 1);
Color kTertiaryColorContainer90 = const Color.fromRGBO(241, 249, 232, 1);
Color kOnTertiaryColorContainer10 = const Color.fromRGBO(52, 78, 20, 1);

Color kErrorColor40 = const Color.fromRGBO(179, 38, 30, 1);
Color kOnErrorColor100 = const Color.fromRGBO(255, 255, 255, 1);
Color kErrorColorContainer90 = const Color.fromRGBO(249, 222, 220, 1);
Color kOnErrorColorContainer10 = const Color.fromRGBO(65, 14, 11, 1);

Color kSuccessColor40 = const Color.fromRGBO(75, 103, 8, 1);
Color kOnSuccessColor100 = const Color.fromRGBO(255, 255, 255, 1);
Color kSuccessColorContainer90 = const Color.fromRGBO(205, 239, 133, 1);
Color kSuccessColorContainer10 = const Color.fromRGBO(19, 31, 0, 1);

Color kInfoColor = const Color.fromRGBO(252 , 224 , 121, 1);


const double kPaddingExternalDefault = 20;
const double kPaddingDefault = 20;
const double kMarginExternalDefault = 20;
const double kMarginDefault = 20;
const double kBorderDefault = 15;
double kHeightDefault = Get.height;
double kWidthDefault = Get.width;

//FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//Theme.of(context).textTheme.bodyText2?.fontSize

var pixelDevice = Get.pixelRatio;