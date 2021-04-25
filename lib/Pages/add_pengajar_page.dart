import 'package:flutter/material.dart';
import 'package:student_doctor/Utils/Atom/color.dart';
import 'package:student_doctor/Utils/Atom/teks.dart';
import 'package:student_doctor/Utils/Func/Dosen/dosen_function.dart';
import 'package:student_doctor/Utils/Molekul/text_field.dart';

class AddPengajarPage extends StatefulWidget {
  @override
  _AddPengajarPage createState() => _AddPengajarPage();
}

class _AddPengajarPage extends State<AddPengajarPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namaText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: teks(teks: "TAMBAH LIST DOSEN"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            textFormField(namaText, "Nama Dosen", TextInputType.text),
            Padding(
              padding: const EdgeInsets.only(top: 10),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  createDosen(namaText.text, context);
                  namaText.clear();
                }
              },
              child: Text('SIMPAN'),
            ),
          ],
        ),
      ),
    );
  }
}
