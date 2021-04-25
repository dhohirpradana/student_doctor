import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student_doctor/Models/mk_model.dart';

class MKDbProvider {
  Future<Database> init() async {
    Directory directory =
        await getApplicationDocumentsDirectory(); //returns a directory which stores permanent files
    final path =
        join(directory.path, "student_doctor.db"); //create path to database

    return await openDatabase(
        //open the database or create a database if there isn't any
        path,
        version: 1, onCreate: (Database db, int version) async {
      // Create * database + tables for consumtion then
      await db.execute("""
          CREATE TABLE MK(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nama TEXT,
          pengajar TEXT,
          sks INTEGER,
          hari TEXT,
          waktu TEXT)""");
      await db.execute("""
          CREATE TABLE Task(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          mk_id INTEGER,
          value TEXT,
          deadline INTEGER,
          progress INTEGER,
          created_at INTEGER)""");
      await db.execute("""
          CREATE TABLE Dosen(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nama TEXT)""");
    });
  }

  Future<int> addMK(MKModel data) async {
    //returns number of items inserted as an integer

    final db = await init(); //open database

    return db.insert(
      "MK", data.toMap(), //toMap() function from MemoModel
      conflictAlgorithm:
          ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
    );
  }

  Future<List<MKModel>> fetchMK() async {
    //returns the mk as a list (array)

    final db = await init();
    final maps = await db
        .query("MK"); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of mk
      return MKModel(
        id: maps[i]['id'],
        nama: maps[i]['nama'],
        pengajar: maps[i]['pengajar'],
        sks: maps[i]['sks'],
        hari: maps[i]['hari'],
        waktu: maps[i]['waktu'],
      );
    });
  }

  Future<int> deleteMK(int id) async {
    //returns number of items deleted
    final db = await init();

    int result = await db.delete("MK", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
        );

    return result;
  }

  Future<int> updateMK(int id, MKModel item) async {
    // returns the number of rows updated

    final db = await init();

    int result =
        await db.update("MK", item.toMap(), where: "id = ?", whereArgs: [id]);
    return result;
  }
}
