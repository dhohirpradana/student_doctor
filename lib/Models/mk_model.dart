class MKModel {
  final int id;
  final String nama;
  final String pengajar;
  final int sks;
  final String hari;
  final String waktu;

  MKModel({this.id, this.nama, this.pengajar, this.hari, this.waktu, this.sks});

  Map<String, dynamic> toMap() {
    // used when inserting data to the database
    return <String, dynamic>{
      "id": id,
      "nama": nama,
      "pengajar": pengajar,
      "sks": sks,
      "hari": hari,
      "waktu": waktu,
    };
  }
}
