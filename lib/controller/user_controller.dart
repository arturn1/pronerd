import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pronerd/models/user.dart';

import '../models/user.dart';
import '../screens/base.dart';
import '../screens/login/login_screen.dart';
import '../utils/constants.dart';

class UserController extends GetxController {

  late Rx<User?> _user;
  late final Rx<UserModel?> _localUser = const UserModel().obs;
  late UserModel? _userModel = const UserModel();

  UserModel? get userModel => _userModel;

  Rx<UserModel?> get localUser => _localUser;

  setUser(UserModel? value) => _userModel = value;

  @override
  void onInit() {
    super.onInit();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.offAll(() => const LoginScreen());
      });
    } else {
      Future.delayed(const Duration(milliseconds: 2500), () async {
        actualUser(await getUserFromDB(user.uid));
        Get.offAll(() => const BaseScreen());
      });
    }
  }

  actualUser(UserModel? user) {
    setUser(user);
  }

  Future<UserModel> getUserFromDB(String uid) async {
    var dataList =
        await firestore.collection("users").where("uid", isEqualTo: uid).get();
    return UserModel.fromSnap(dataList.docs.last);
  }

}
