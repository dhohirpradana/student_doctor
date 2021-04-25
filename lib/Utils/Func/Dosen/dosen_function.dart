import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:student_doctor/Database/dosen_db_provider.dart';
import 'package:student_doctor/Models/dosen_model.dart';

DosenDbProvider dosenDb = DosenDbProvider();
void loadDosenData(typeList) async {
  WidgetsFlutterBinding.ensureInitialized();
  final data = await dosenDb.fetchDosen();
  for (var i = 0; i < data.length; i++) {
    typeList.add(data[i]);
  }
}

void createDosen(nama, context) async {
  WidgetsFlutterBinding.ensureInitialized();
  final dosen = DosenModel(nama: nama);
  await dosenDb.addDosen(dosen);
  AwesomeDialog(
    dismissOnTouchOutside: false,
    context: context,
    animType: AnimType.SCALE,
    dialogType: DialogType.SUCCES,
    title: 'SUCCES',
    desc: 'Tambah Dosen berhasil',
    btnOkOnPress: () {},
  )..show();
}

void deleteDosen(id) {
  dosenDb.deleteDosen(id);
}
