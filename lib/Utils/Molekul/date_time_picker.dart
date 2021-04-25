import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget dateTime(dateTimeOnChange) => CupertinoDatePicker(
    minimumDate: DateTime.now(),
    use24hFormat: true,
    initialDateTime: DateTime.now(),
    onDateTimeChanged: dateTimeOnChange);
