import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pronerd/models/user.dart';

import '../utils/constants.dart';


class ProfileController extends GetxController {
  final Rx<UserModel> _user = const UserModel().obs;
  final Rx<String> _url = ''.obs;
  final Rx<String> _uid = "".obs;

  UserModel get user => _user.value;
  String get url => _url.value;


  Future<void> updateUserId(String uid) async {
    _uid.value = uid;
    await getUserData();
    print(_uid.value);
  }

  getUserData() async {
    List<String> thumbnails = [];
    var user = await firestore
        .collection('users')
        .where('uid', isEqualTo: _uid.value)
        .get();
    _user.value =  UserModel.fromSnap(user.docs.single);
  }

  getUserDataByUID(String uid) async {
    var user = await firestore
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();
    var url = "";
    url =  UserModel.fromSnap(user.docs.single).photoUrl;
    return url;
  }

}