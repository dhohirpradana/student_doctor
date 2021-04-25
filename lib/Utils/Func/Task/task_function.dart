import 'package:flutter/material.dart';
import 'package:student_doctor/Database/task_db_provider.dart';
import 'package:student_doctor/Models/task_model.dart';

TaskDbProvider taskDb = TaskDbProvider();

void createTask({@required mkId, value, deadline, progress, createdAt}) async {
  WidgetsFlutterBinding.ensureInitialized();
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final task = TaskModel(
    mkId: mkId,
    value: "Test",
    deadline: deadline.millisecondsSinceEpoch,
    progress: progress.ceil(),
    createdAt: timestamp,
  );
  await taskDb.addTask(task);
  var tasks = await taskDb.fetchTask();
  print(tasks.length);
}

void deleteTask(id) {
  taskDb.deleteTask(id);
}
