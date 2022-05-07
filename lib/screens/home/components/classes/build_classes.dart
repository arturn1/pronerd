import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pronerd/components/build_btn.dart';
import 'package:pronerd/controller/auth_controller.dart';
import 'package:pronerd/controller/task_controller.dart';
import 'package:pronerd/test.dart';

import '../../../../components/build_add_room.dart';
import '../../../../controller/class_controller.dart';
import '../../../../controller/profile_controller.dart';
import '../../../../controller/search_controller.dart';
import '../../../../utils/constants.dart';
import '../../../search/search_screen.dart';
import 'build_card_classes.dart';

class BuildClassHome extends StatelessWidget {
  const BuildClassHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController auth = Get.find();

    return Container(
      padding : const EdgeInsets.only(top: kMarginDefault*1.5),
      color: kPrimaryBarColor,
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20.0, bottom: 10),
                child: const Text(
                  'Meus grupos',
                  style: kLabelHeadStyle,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 10),
                child: IconButton(
                  onPressed: () => Get.bottomSheet(
                      const CustomBottomSheetAddClass(message: 'Criar grupo')),
                  icon: const Icon(FontAwesomeIcons.houseMedical),
                  color: kOnPrimaryColorContainer10,
                ),
              )
            ],
          ),
          GetX<ClassController>(
              init: Get.put(ClassController()),
              builder: (ClassController classController) {
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: classController.classListByUser.value.isEmpty
                        ? 1
                        : classController.classListByUser.value.length + 1,
                    itemBuilder: (_, index) => (index == 0)
                        ? GestureDetector(
                            onTap: () => {
                              Get.to(
                                () => const SearchScreen(),
                                transition: Transition.downToUp,
                                duration: const Duration(milliseconds: 400),
                              )
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: kSecondaryColorContainer90,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      Icons.search,
                                      color: kOnSecondaryColorContainer10,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Procurar grupo',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'myFont', fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          )
                        : ClassesCard(
                            uid: auth.user.uid,
                            roomModel: classController
                                .classListByUser.value[index - 1]),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
