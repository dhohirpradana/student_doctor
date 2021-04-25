import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student_doctor/Models/task_model.dart';

class TaskDbProvider {
  Future<Database> init() async {
    Directory directory =
        await getApplicationDocumentsDirectory(); //returns a directory which stores permanent files
    final path =
        join(directory.path, "student_doctor.db"); //create path to database

    return await openDatabase(path, version: 1);
  }

  Future<int> addTask(TaskModel data) async {
    //returns number of items inserted as an integer
    //
    final db = await init(); //open database

    return db.insert(
      "Task", data.toMap(), //toMap() function from MemoModel
      conflictAlgorithm:
          ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
    );
  }

  Future<List<TaskSelectorModel>> fetchTask() async {
    //returns the Tasks as a list (array)

    final db = await init();
    final maps = await db.rawQuery(
        'SELECT Task.id, MK.nama AS mk_nama, Task.value, Task.deadline, Task.progress, Task.created_at from MK INNER JOIN Task ON Mk.id=Task.mk_id');

    // final maps = await db
    //     .query("Task"); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of tasks
      return TaskSelectorModel(
          id: maps[i]['id'],
          mkNama: maps[i]['mk_nama'],
          value: maps[i]['value'],
          deadline: maps[i]['deadline'],
          progress: maps[i]['progress'],
          createdAt: maps[i]['created_at']);
    });
  }

  Future<int> deleteTask(int id) async {
    //returns number of items deleted
    final db = await init();

    int result = await db.delete("Task", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
        );

    return result;
  }

  Future<int> updateTask(int id, TaskModel item) async {
    // returns the number of rows updated

    final db = await init();

    int result =
        await db.update("Task", item.toMap(), where: "id = ?", whereArgs: [id]);
    return result;
  }
}
