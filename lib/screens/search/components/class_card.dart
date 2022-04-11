import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:overflow_view/overflow_view.dart';

import '../../../controller/class_controller.dart';
import '../../../controller/date_picker_controller.dart';
import '../../../controller/post_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../../controller/task_controller.dart';
import '../../../models/room.dart';
import '../../../utils/constants.dart';
import '../../class/class_screen.dart';

class ClassesCard extends StatelessWidget {
  const ClassesCard({Key? key, required this.roomModel}) : super(key: key);

  final RoomModel roomModel;

  @override
  Widget build(BuildContext context) {
    DateController dateController = Get.find();
    ClassController classController = Get.find();
    TaskController taskController = Get.find();
    PostController postController = Get.find();
    ProfileController profileController = Get.find();

    return InkWell(
      splashColor: Colors.red,
      highlightColor: Colors.green,
      hoverColor: Colors.yellow,
      onTap: () => {
        postController.onClick(roomModel.classId),
        taskController.onClick(roomModel.classId),
        classController.getData(roomModel).then((v) => Get.to(
              () => ClassFeed(roomModel: roomModel),
              // transition: Transition.rightToLeft
            ))
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          elevation: 4,
          child: Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: kOnPrimaryColorContainer10
              ),
              color: kPrimaryColorContainer90,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   color:kOnPrimaryColorContainer10,
                      // ),
                      borderRadius: BorderRadius.circular(15),
                    color: kPrimarySurface,
                    ),
                    height: 35,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        roomModel.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                            color: kOnPrimaryColorContainer10,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                   'Criado por:  ',
                    style: TextStyle(
                        color: kOnPrimaryColorContainer10,
                        fontSize: 16),
                  ),
                  Text(
                   roomModel.userName,
                    style: TextStyle(
                        color: kOnPrimaryColorContainer10,
                        fontSize: pixelDevice == 3 ? 14 : 20),
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(bottom: kMarginDefault/2),
                    height: 40,
                    width: 80,
                    child: OverflowView.flexible(
                      direction: Axis.horizontal,
                      spacing: 4,
                      children: <Widget>[
                        for (int i = 0; i < roomModel.followers.length; i++)
                          FutureBuilder(
                            future: profileController
                                .getUserDataByUID(roomModel.followers[i]),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                return CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot.data),
                                );
                              }
                              return const SizedBox(
                                  height: 30,
                                  child: GFLoader(
                                    type: GFLoaderType.custom,
                                    loaderIconOne   : Icon(Icons.insert_emoticon),
                                  ));
                            },
                          ),
                      ],
                      builder: (context, remaining) {
                        return Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: kSecondaryColorContainer90,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                              child: Text(
                            '+$remaining',
                            style: TextStyle(color: kOnSecondaryColorContainer10),
                          )),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
