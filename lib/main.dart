import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/screens/base.dart';
import 'package:pronerd/screens/home/home_screen.dart';
import 'package:pronerd/screens/login/login_screen.dart';
import 'package:pronerd/screens/splash_screen.dart';
import 'package:pronerd/utils/constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'bindings/home_bindings.dart';
import 'controller/auth_controller.dart';
import 'controller/class_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      defaultTransition: Transition.fadeIn,
      theme: ThemeData(
        fontFamily: 'myFont',
        scaffoldBackgroundColor: kPrimarySurface,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      home: const CustomSplashScreen(),
    );
  }
}
