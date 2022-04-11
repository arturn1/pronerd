import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../models/task.dart';

class DateController extends GetxController {
  //Rxn<DateTime> myDate = Rxn<DateTime>();
  Rx<DateTime> myDate = DateTime.now().obs;
  Rx<DateTime>? pickedDate = DateTime.now().obs;

  TextEditingController textController = TextEditingController();
  setDate(DateTime value) => pickedDate!.value = value;

  presentDatePicker(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      locale: const Locale('pt', 'BR'),
        context: context,
        initialDate: myDate.value,
        firstDate: DateTime(2020),
        lastDate: DateTime(2024));
    // Check if no date is selected
    if (selected == null) {
      return;
    }
    textController.text = showCorrectDate(selected);
    setDate(selected);
  }

  Future<DateTime> postDateFilter(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: myDate.value,
        firstDate: DateTime(2020),
        lastDate: DateTime(2024));
    // Check if no date is selected
    if (selected == null) {
      return DateTime.now();
    }
    return selected;
  }


  DateTime get selectedDate => pickedDate!.value;

  showDateNow() {
    return "${myDate.value.day}/${myDate.value.month}/${myDate.value.year}";
  }

  showCorrectDate(DateTime d) {
    return "${d.day}/${d.month}/${d.year}";
  }

  showDateLikeInsta (DateTime d) {
    return Jiffy(d).format('d MMM');
  }

  String getDate(TaskModel taskModel) {
    switch (taskModel.finalDate
        .difference(DateTime.now())
        .inDays) {
      case 0:
        return taskModel.finalDate.day == DateTime.now().day ? 'É hoje' : 'Amanhã';
      case 1:
        return "Depois de amanhã";
      default:
        return "Faltam " +
            taskModel.finalDate
                .difference(DateTime.now())
                .inDays
                .toString() +
            " dias";
    }
  }

  String getOnlyDate(TaskModel taskModel) {
    return (taskModel.finalDate
        .difference(DateTime.now())
        .inDays).toString();
  }

}
