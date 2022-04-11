import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controller/search_controller.dart';
import '../../../utils/constants.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

  SearchController controller = Get.put(SearchController());

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF5F6F9),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      margin: const EdgeInsets.all(kMarginDefault),
      height: 45,
      child: TextFormField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(15),
          ],
          onChanged: (v) => { },
          cursorColor: Colors.black,
          style: const TextStyle(
            fontSize: 18,
          ),
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlue, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 2.0),
              ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
               //borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.search, color: Colors.black54),
            suffixIcon: IconButton(
              icon: const Icon(Icons.cancel_rounded, color: Colors.black54),
              onPressed: () {
                FocusScope.of(context).unfocus();
                controller.reset();
              },
            ),
            hintText: 'Pesquisar ...',
            hintStyle: const TextStyle(
              color: Colors.black26
            )
            //label: const Text('Pesquisar ...',
            //style: TextStyle(
            //  color: Colors.black26
            //),
            //),
            //floatingLabelStyle: const TextStyle(
            //
            //)
            // border: const OutlineInputBorder()),
          )),
    );
  }
}
