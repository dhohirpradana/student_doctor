import 'package:flutter/material.dart';
import 'package:student_doctor/Utils/Atom/screen_utils_size.dart';

Widget dropdownHari(dropdownValue) => DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: screenUtilSize(24),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.green,
      ),
      onChanged: (String newValue) {
        dropdownValue = newValue;
      },
      items: <String>[
        'SENIN',
        'SELASA',
        'RABU',
        'KAMIS',
        "JUM'AT",
        'SABTU',
        'MINGGU'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        );
      }).toList(),
    );
