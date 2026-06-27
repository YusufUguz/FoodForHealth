import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_health/core/constants/app_colors.dart';
import 'package:food_for_health/core/general_functions/pick_date.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CustomDatePicker extends StatelessWidget {
  CustomDatePicker({super.key, required this.selectedDate, required this.icon});

  ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 2, color: AppColors.appsMainColor)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon),
                ValueListenableBuilder(
                    valueListenable: selectedDate,
                    builder: (context, selectedDateValue, child) {
                      return Text(
                        DateFormat('dd/MM/yyyy').format(selectedDateValue).toString(),
                        style: TextStyle(fontSize: 18),
                      );
                    }),
              ],
            ),
            SizedBox(height: 20),
            IconButton(
              onPressed: () => pickDate(context, selectedDate),
              icon: Icon(FontAwesomeIcons.calendar, color: AppColors.appsMainColor),
            ),
          ],
        ),
      ),
    );
  }
}
