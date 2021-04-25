import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

Future<Null> selectTime(BuildContext context) async {
  String _hour, _minute, _time;

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _timeController = TextEditingController();
  final TimeOfDay picked = await showTimePicker(
    context: context,
    initialTime: selectedTime,
  );
  if (picked != null)
    // setState(() {
    selectedTime = picked;
  _hour = selectedTime.hour.toString();
  _minute = selectedTime.minute.toString();
  _time = _hour + ' : ' + _minute;
  _timeController.text = _time;
  _timeController.text = formatDate(
      DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
      [hh, ':', nn, " ", am]).toString();
  // });
}
