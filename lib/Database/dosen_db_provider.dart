import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student_doctor/Models/dosen_model.dart';

class DosenDbProvider {
  Future<Database> init() async {
    Directory directory =
        await getApplicationDocumentsDirectory(); //returns a directory which stores permanent files
    final path =
        join(directory.path, "student_doctor.db"); //create path to database

    return await openDatabase(path, version: 1);
  }

  Future<int> addDosen(DosenModel data) async {
    //returns number of items inserted as an integer
    //
    final db = await init(); //open database

    return db.insert(
      "Dosen", data.toMap(), //toMap() function from MemoModel
      conflictAlgorithm:
          ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
    );
  }

  Future<List<String>> fetchDosen() async {
    final db = await init();
    final usersData = await db.query("Dosen");
    return usersData.map((Map<String, dynamic> row) {
      return row["nama"] as String;
    }).toList();
  }

  Future<List<DosenModel>> fetchDosenToModel() async {
    //returns the mk as a list (array)

    final db = await init();
    final maps = await db
        .query("Dosen"); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of mk
      return DosenModel(id: maps[i]['id'], nama: maps[i]['nama']);
    });
  }

  Future<int> deleteDosen(int id) async {
    //returns number of items deleted
    final db = await init();

    int result = await db.delete("Dosen", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
        );

    return result;
  }

  Future<int> updateDosen(int id, DosenModel item) async {
    // returns the number of rows updated

    final db = await init();

    int result = await db
        .update("Dosen", item.toMap(), where: "id = ?", whereArgs: [id]);
    return result;
  }
}
