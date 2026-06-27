import 'package:flutter/material.dart';

void pickDate(BuildContext context, dynamic selectedDate) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );

  if (pickedDate != null) {
    selectedDate.value = pickedDate;
  }
}
