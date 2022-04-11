import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pronerd/components/build_snack_bar.dart';
import 'package:pronerd/controller/class_controller.dart';
import 'package:pronerd/controller/task_controller.dart';
import 'package:pronerd/models/user.dart' as model;
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/login/login_screen.dart';
import '../screens/splash_screen.dart';

class AuthController extends GetxController {
  var firebaseAuth = FirebaseAuth.instance;
  var firebaseStorage = FirebaseStorage.instance;
  var firestore = FirebaseFirestore.instance;

  // TaskController taskController = Get.put(TaskController());

  // void updateHome() {
  //   taskController.updateHome();
  // }

  static AuthController instance = Get.find();
  AwesomeController awesomeController = Get.put(AwesomeController());

  final RxString _email = ''.obs;
  final RxString _password = ''.obs;
  final RxString _bio = ''.obs;

  final RxString _newEmail = ''.obs;
  final RxString _newPassword = ''.obs;
  final RxString _newUserName = ''.obs;
  final RxString _newConfirmedPassword = ''.obs;

  setEmail(String value) => _email.value = value;

  setBio(String value) => _bio.value = value;

  setPassword(String value) => _password.value = value;

  setNewEmail(String value) => _newEmail.value = value;

  setNewPassword(String value) => _newPassword.value = value;

  setNewConfirmedPassword(String value) =>
      _newConfirmedPassword.value = value;

  setNewName(String value) => _newUserName.value = value;

  String get newUserName => _newUserName.value;

  String get email => _email.value;
  String get password => _password.value;
  String get bio => _bio.value;

  // late Rx<User?> _user;

  //UserModel? _userModel = const UserModel();

  User get user => awesomeController.user;

  // UserModel? get userModel => _userModel
  // ;

  // @override
  // void onReady() {
  //   super.onReady();
  //   _user = Rx<User?>(firebaseAuth.currentUser);
  //   // _user.value == null
  //   //     ? _user.value
  //   //     : _userModel = userMapGoogleToUser(_user.value);
  //   _user.bindStream(firebaseAuth.authStateChanges());
  //   ever(_user, _setInitialScreen);
  // }
  //
  // _setInitialScreen(User? user) {
  //   Future.delayed(const Duration(milliseconds: 2500), () {
  //     if (user == null) {
  //       Get.offAll(() => const LoginScreen());
  //     } else {
  //       Get.offAll(() => const CustomSplashScreen());
  //     }
  //   });
  // }

  Future<void> registerUser() async {
    try {
      if (_newUserName.isNotEmpty &&
          _newEmail.isNotEmpty &&
          _newPassword.isNotEmpty && _newConfirmedPassword.isNotEmpty) {
        // save out user to our ath and firebase firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: _newEmail.value,
          password: _newPassword.value,
        );

        User? user = cred.user!;

        await user.updateDisplayName(_newUserName.value);
        await user.updatePhotoURL(
            'https://avatars.githubusercontent.com/u/31557902?v=4');

        model.UserModel userModel = model.UserModel(
            userName: _newUserName.value,
            email: _newEmail.value,
            uid: cred.user!.uid,
            photoUrl: 'https://avatars.githubusercontent.com/u/31557902?v=4',
            followers: [],
            following: []);
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(userModel.toJson());
      } else {
        CustomSnack().buildCardError('Insira todos os campos');
      }
    } catch (e) {
      CustomSnack().buildCardError('E-mail já cadastrado');
      rethrow;
    }
  }

  Future<void> loginUser() async {
    try {
      if (_email.value.isNotEmpty && _password.value.isNotEmpty) {
        final userCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: _email.value, password: _password.value);
        final user = userCredential.user;
        //_userModel = userMapGoogleToUser(user);
        //CustomSnack().buildCardSuccess('Usuário criado com sucesso');
        //updateHome();
      } else {
        //CustomSnack().buildCardError('Preencha todos os campos');
      }
    } catch (e) {
      CustomSnack().buildCardError('E-mail ou senha inválidos.');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    Get.delete<ClassController>();
    reset();
  }

  bool enableButton() {
    //CustomSnack().buildCardError('Insira todos os campos');

    return _email.value.isNotEmpty && _password.value.isNotEmpty;
  }

  bool enableRegisterButton() {
    return _newUserName.isNotEmpty &&
         _newEmail.isNotEmpty && _newConfirmedPassword.value.length > 8 &&
         _newPassword.value.length > 8 && _newEmail.value.isEmail && _newConfirmedPassword.value == _newPassword.value;
  }

  Future<void> refreshBio() async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'bio': bio}).whenComplete(() => CustomSnack().buildCardInformation('Bio atualizada'));
  }



  Future doNothing() async {
    CustomSnack().buildCardError('Preencha todos os campos com dados válidos');

    return null;
  }

  reset() {
    setEmail('');
    setPassword('');
    setNewEmail('');
    setNewPassword('');
    setNewConfirmedPassword('');
    setNewName('');
  }

  Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        CustomSnack().buildCardError(e.toString());
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
          model.UserModel userModel = userMapGoogleToUser(user);

          await firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set(userModel.toJson());

        } on FirebaseAuthException catch (e) {
          CustomSnack().buildCardError(e.code.toString());
        } catch (e) {
          CustomSnack().buildCardError(e.toString());
        }
      }
    }

    return user;
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

  String? getNameError(String? value) {
    if (value!.isEmpty) {
      return 'Campo Obrigatorio';
    } else {
      return null;
    }
  }

  String? getEmailError(String? value) {
    if (value!.isEmpty) {
      return ('Campo Obrigatorio');
    } else if (!value.isEmail) {
      return ('E-mail invalido');
    } else {
      return null;
    }
  }

  String? getEmptyError(String? value) {
    if (value!.isEmpty) {
      return ('Campo Obrigatorio');
    } else {
      return null;
    }
  }

  String? getPasswordError(String? value) {
    if (value!.length <= 8) {
      return 'A senha deve conter mais de 8 caracteres';
    } else {
      return null;
    }
  }

  String? getConfirmPasswordError(String? value) {
    if (value != _newPassword.value) {
      return 'As senhas nao coincidem';
    } else {
      return null;
    }
  }
}

// void forgotPass({required String email}) async {
//   if (email.isEmpty) {
//     DialogHelper.hideLoading();
//     DialogHelper.showSnackBar(strMsg: 'Please fill valid email!');
//   } else {
//
//     if (Get.isDialogOpen!) Get.back();
//     try {
//       await firebaseAuth.sendPasswordResetEmail(
//           email: email);
//       DialogHelper.hideLoading();
//       DialogHelper.showErrorDialog(title: "Reset Password", description:
//       "Please check your email and click on the provided link to reset your password.");
//
//     } on FirebaseAuthException catch (e) {
//       DialogHelper.hideLoading();
//       DialogHelper.showSnackBar(strMsg: e.code);
//     } catch (e) {
//       DialogHelper.hideLoading();
//       DialogHelper.showSnackBar(strMsg: e.toString());
//     }
//   }
// }

//
//
// class DialogHelper {
//   //show error dialog
//   static void showErrorDialog({String title = 'Error', String? description = 'Something went wrong'}) {
//     Get.dialog(
//       Dialog(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 title,
//                 style: Get.textTheme.headline4,
//               ),
//               Text(
//                 description ?? '',
//                 style: Get.textTheme.headline6,
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   if (Get.isDialogOpen!) Get.back();
//                 },
//                 child: const Text('Okay'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   //show snack bar
//   static void showSnackBar({String title = "Alert!",required String strMsg}){
//     Get.snackbar(title, strMsg,backgroundColor: Colors.black, colorText: Colors.white,
//         snackPosition: SnackPosition.BOTTOM
//     );
//   }
//
//
//   //show loading
//   static void showLoading([String? message]) {
//     Get.dialog(
//       Dialog(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const CircularProgressIndicator(),
//               const SizedBox(height: 8),
//               Text(message ?? 'Loading...'),
//             ],
//           ),
//         ),
//       ),
//       barrierDismissible: false,
//     );
//   }
//
//   //hide loading
//   static void hideLoading() {
//     if (Get.isDialogOpen!) Get.back();
//   }
//
//   //hide keybord
//
//   static hideKeyboard() {
//     FocusManager.instance.primaryFocus?.unfocus();
//   }
//
// }