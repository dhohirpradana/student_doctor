class DosenModel {
  final int id;
  final String nama;

  DosenModel({this.id, this.nama});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{"id": id, "nama": nama};
  }
}
