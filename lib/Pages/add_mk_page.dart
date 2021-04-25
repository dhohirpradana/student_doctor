import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_doctor/Utils/Atom/color.dart';
import 'package:student_doctor/Utils/Atom/gap.dart';
import 'package:student_doctor/Utils/Atom/screen_utils_size.dart';
import 'package:student_doctor/Utils/Atom/teks.dart';
import 'package:student_doctor/Utils/Func/Dosen/dosen_function.dart';
import 'package:student_doctor/Utils/Func/MK/mk_function.dart';
import 'package:student_doctor/Utils/Molekul/Dosen/dosen_molekul.dart';
import 'package:student_doctor/Utils/Molekul/text_field.dart';

class AddMKPage extends StatefulWidget {
  AddMKPage({Key key}) : super(key: key);
  @override
  _AddMKPage createState() => _AddMKPage();
}

class _AddMKPage extends State<AddMKPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => loadDosenData(_dosenList));
    _dateController.text = DateFormat.yMd().format(DateTime.now());
    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
  }

  List<String> _dosenList = [];

  final _formKey = GlobalKey<FormState>();
  TextEditingController namaText = TextEditingController();
  TextEditingController dosenText = TextEditingController();
  TextEditingController sksText = TextEditingController();
  String dropdownValue = 'SENIN';
  double _height;
  double _width;

  String setTime = '12';
  String _hour, _minute, _time;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: teks(teks: "TAMBAH MAKUL"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            gap(tinggi: 5),
            textFormField(namaText, "Nama Mata Kuliah", TextInputType.text),
            autocompleteTextField(dosenText, _dosenList),
            textFormField(sksText, "SKS", TextInputType.number),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Colors.grey,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<String>(
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
                  ),
                  InkWell(
                    onTap: () {
                      selectTime(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: screenUtilSize(10), bottom: screenUtilSize(10)),
                      width: _width / 3,
                      height: _height / 14,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                        onChanged: (value) => setTime = value,
                        onSaved: (String val) {
                          setTime = val;
                        },
                        enabled: false,
                        keyboardType: TextInputType.text,
                        controller: _timeController,
                        decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            // labelText: 'Time',
                            contentPadding: EdgeInsets.all(5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  createMK(namaText.text, dosenText.text, sksText.text,
                      dropdownValue, _timeController.text, context);
                  namaText.clear();
                  dosenText.clear();
                  sksText.clear();
                }
              },
              child: Text('SIMPAN'),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }
}
