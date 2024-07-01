import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

class TimeDate extends StatefulWidget {
  const TimeDate({
    super.key,
    required this.selectedTime,
  });

  final Function(DateTime) selectedTime;

  @override
  State<TimeDate> createState() => _TimeDateState();
}

class _TimeDateState extends State<TimeDate> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.blue,
        selectedTextColor: Colors.white,
        onDateChange: widget.selectedTime,
      ),
    );
  }
}