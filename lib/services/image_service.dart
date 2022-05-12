import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pronerd/models/user.dart';
import 'package:uuid/uuid.dart';

import '../utils/constants.dart';

abstract class ImageService {
  Future<File?> getFromCameraService(BuildContext context) async {
    final pickedFile =
        (await ImagePicker().pickImage(source: ImageSource.camera));
    final File image = File(pickedFile!.path);
    return image;
  }

  Future<File?> getFromGalleryService(BuildContext context) async {
    final pickedFile =
        (await ImagePicker().pickImage(source: ImageSource.gallery));
    final File image = File(pickedFile!.path);
    return image;
  }

  Future<String> uploadImageToStorageService(
      File file, bool isPost, UserModel? userModel) async {
    Reference ref = firebaseStorage.ref().child('posts').child(userModel!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
