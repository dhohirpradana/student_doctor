import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:student_doctor/Database/mk_db_provider.dart';
import 'package:student_doctor/Models/mk_model.dart';

MKDbProvider mkDb = MKDbProvider();
void createMK(nama, dosen, sks, hari, jam, context) async {
  WidgetsFlutterBinding.ensureInitialized();

  final mk = MKModel(
    // id: 1,
    nama: nama,
    pengajar: dosen,
    sks: int.parse(sks),
    hari: hari,
    waktu: jam,
  );

  await mkDb.addMK(mk);
  AwesomeDialog(
    dismissOnTouchOutside: false,
    context: context,
    animType: AnimType.SCALE,
    dialogType: DialogType.SUCCES,
    title: 'SUCCES',
    desc: 'Tambah Mata Kuliah berhasil',
    btnOkOnPress: () {},
  )..show();
}

void deleteMK(id) async {
  await mkDb.deleteMK(id);
  print(await mkDb.fetchMK());
}
