import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';


class CustomLoader extends StatelessWidget {
  const CustomLoader(
      {Key? key,
      required this.getData,
      required this.getBack,
      required this.getTo})
      : super(key: key);

  final Future getData;
  final Function getTo;
  final Function getBack;

  @override
  Widget build(BuildContext context) {

    return Container(
        color: Colors.white,
        child: FutureBuilder(
          future: getData,
          builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                   Future.delayed(Duration.zero, () async {
                    getTo();
                   });
                }
                if (snapshot.hasError) {
                  Future.delayed(Duration.zero, () async {
                    getBack();
                  });
                }
            return const Center(
              child: GFLoader(
                type: GFLoaderType.circle,
                loaderColorOne: Colors.blue,
                loaderColorTwo: Colors.blueAccent,
                loaderColorThree: Colors.blue,
              ),
            );
          },
        ));
  }
}
