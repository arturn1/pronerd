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

  Rx<UserModel?> get localModel => _localUser;

  setUser(UserModel? value) => _userModel = value;

  @override
  void onInit() {
    super.onInit();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    _localUser.bindStream(getUserFromDB(_user.value!.uid));
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.offAll(() => const LoginScreen());
      });
    } else {
      Future.delayed(const Duration(milliseconds: 2500), () {
        actualUser(localModel.value);
        Get.offAll(() => const BaseScreen());
      });
    }
  }

  actualUser(UserModel? user) {
    setUser(user);
  }

   Stream<UserModel> getUserFromDB(String uid) {
    return firestore
        .collection("users")
        .where("uid", isEqualTo: uid)
        .snapshots().map((e) =>
        UserModel.fromSnap(e.docs.last)
    );
  }

  // Stream<List<UserModel>> getUserFromDB(String classId) {
  //   return firestore
  //       .collection("users")
  //       .where("uid", isEqualTo: classId)
  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     List<UserModel> retVal = [];
  //     for (var element in query.docs) {
  //       retVal.add(UserModel.fromSnap(element));
  //     }
  //     return retVal;
  //   });
  // }
}
