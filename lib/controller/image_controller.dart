import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pronerd/components/build_add_image_screen.dart';
import 'package:pronerd/controller/user_controller.dart';
import 'package:pronerd/models/test.dart';
import 'package:pronerd/services/image_service.dart';
import 'package:uuid/uuid.dart';

import '../utils/constants.dart';
import 'auth_controller.dart';

class ImageController extends GetxController with ImageService {
  UserController userController = Get.find();

  Future<void> getFromCamera(BuildContext context, String source) async {
    try {
      File? image;

      if (source == 'camera') {
        image = await getFromCameraService(context);
      } else if (source == 'gallery') {
        image = await getFromGalleryService(context);
      }

      if (image == null) return;
      Get.to(() => ConfirmScreen(
            imagePath: image!.path,
            context: context,
          ));
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadImageToStorage(File file, bool isPost)  {
    return  uploadImageToStorageService(
        file, isPost, userController.userModel);
  }
}
