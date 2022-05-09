import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pronerd/models/user.dart' as model;


import '../models/user.dart';
import '../screens/base.dart';
import '../screens/login/login_screen.dart';
import '../utils/constants.dart';


class UserController extends GetxController {
  late Rx<User?> _user;

  late UserModel? _userModel = const UserModel();
  UserModel? get userModel => _userModel;
  setUser(UserModel value) => _userModel = value;

  User? get user => _user.value;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);

  }

  model.UserModel userMapGoogleToUser(User? user) {
    return model.UserModel(
        userName: user!.displayName!,
        email: user.email!,
        uid: user.uid,
        photoUrl: user.photoURL!,
        followers: [],
        following: []);
  }

  actualUser(UserModel? user){
    setUser(user!);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.offAll(
                () => const LoginScreen()
        );
      });
    } else {
      actualUser(userMapGoogleToUser(user));
      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.offAll(
                () => const BaseScreen()
        );
      });
    }
  }
}