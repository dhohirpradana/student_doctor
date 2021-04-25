class TaskModel {
  final int id;
  final int mkId;
  final String value;
  final int deadline;
  final int progress;
  final int createdAt;

  TaskModel(
      {this.id,
      this.mkId,
      this.value,
      this.deadline,
      this.progress,
      this.createdAt});

  Map<String, dynamic> toMap() {
    // insert data to database
    return <String, dynamic>{
      "id": id,
      "mk_id": mkId,
      "value": value,
      "deadline": deadline,
      "progress": progress,
      "created_at": createdAt,
    };
  }
}

class TaskSelectorModel {
  final int id;
  final String mkNama;
  final String value;
  final int deadline;
  final int progress;
  final int createdAt;

  TaskSelectorModel(
      {this.id,
      this.mkNama,
      this.value,
      this.deadline,
      this.progress,
      this.createdAt});
}
