import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pronerd/components/build_add_image_screen.dart';
import 'package:pronerd/controller/user_controller.dart';
import 'package:pronerd/models/test.dart';
import 'package:uuid/uuid.dart';

import '../utils/constants.dart';
import 'auth_controller.dart';

class ImageController extends GetxController {

  UserController userController = Get.find();

  //File? pickedImageFile;
  late var imageFileFile = ''.obs;
  late var imageFilePath = ''.obs;

  setImageFilePath(value) => imageFilePath.value = value;
  setImageFileFile(value) => imageFileFile.value = value;

  Future<void> getFromCamera(BuildContext context) async {
    final pickedFile =
        (await ImagePicker().pickImage(source: ImageSource.camera));
    if (pickedFile == null) return;
    final File image = File(pickedFile.path);
    Get.to(() => ConfirmScreen(
          imagePath: image.path,
          context: context,
        ));
  }

  Future<void> getFromGallery(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    final image = File(pickedFile.path);
    //setImageFilePath(pickedFile);
    Get.to(() => ConfirmScreen(imagePath: image.path, context: context));
  }

  Future<String> uploadImageToStorage(File file, bool isPost) async {
    // creating location to our firebase storage
    Reference ref =
        firebaseStorage.ref().child('posts').child(userController.userModel!.uid);
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
