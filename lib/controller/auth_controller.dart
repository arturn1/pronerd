import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pronerd/components/build_snack_bar.dart';
import 'package:pronerd/models/user.dart';
import 'package:pronerd/services/auth_service.dart';

import '../utils/constants.dart';

class AuthController extends GetxController with AuthService {

  final RxString _email = ''.obs;
  final RxString _password = ''.obs;

  final RxString _newEmail = ''.obs;
  final RxString _newUserName = ''.obs;
  final RxString _newPassword = ''.obs;
  final RxString _newConfirmedPassword = ''.obs;

  setEmail(String value) => _email.value = value;
  setPassword(String value) => _password.value = value;

  setNewEmail(String value) => _newEmail.value = value;
  setNewName(String value) => _newUserName.value = value;
  setNewPassword(String value) => _newPassword.value = value;
  setNewConfirmedPassword(String value) => _newConfirmedPassword.value = value;


  Future<void> registerUser() async {
    RegisterUserViewModel registerUserViewModel = RegisterUserViewModel(
        name: _newUserName.value,
        email: _newEmail.value,
        password: _newPassword.value,
        confirmPassword: _newConfirmedPassword.value);
    registerUserToGoogle(registerUserViewModel);
  }

  Future<User?> signInWithGoogle() async {
    signInWithGoogleService();
    return null;
  }

  Future<void> loginUser() async {
    LoginViewModel loginViewModel = LoginViewModel(
      name: _email.value,
      email: _email.value,
      password: _newPassword.value,
    );
    loginUserUsingEmailAndPassword(loginViewModel);
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  bool enableLoginButton() {
    return _email.value.isNotEmpty && _password.value.isNotEmpty;
  }

  bool enableRegisterButton() {
    return _newUserName.isNotEmpty &&
        _newEmail.isNotEmpty &&
        _newConfirmedPassword.value.length > 8 &&
        _newPassword.value.length > 8 &&
        _newEmail.value.isEmail &&
        _newConfirmedPassword.value == _newPassword.value;
  }

  Future doNothing() async {
    CustomSnack().buildCardError('Preencha todos os campos com dados válidos');
    return null;
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
