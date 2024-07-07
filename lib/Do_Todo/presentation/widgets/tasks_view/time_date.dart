import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

class TimeDate extends StatefulWidget {
  const TimeDate({
    super.key,
    required this.selectedTime, required this.initialSelectedDate,
  });

  final Function(DateTime) selectedTime;
  final DateTime initialSelectedDate;

  @override
  State<TimeDate> createState() => _TimeDateState();
}

class _TimeDateState extends State<TimeDate> {
  @override
  Widget build(BuildContext context) {
    var dark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 120,
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: widget.initialSelectedDate,
        selectionColor: Colors.blue,
        dateTextStyle: TextStyle(
          color: dark ? Colors.white : Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        dayTextStyle: TextStyle(
          color: dark ? Colors.white : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        monthTextStyle: TextStyle(
          color: dark ? Colors.white : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        selectedTextColor: Colors.white,
        onDateChange: (date)
        {
          widget.selectedTime(date);
        },
      ),
    );
  }
}