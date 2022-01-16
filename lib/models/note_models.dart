class NoteModel {
  int id;
  String title;
  String body;
  DateTime createdTime;

  NoteModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.createdTime});

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
      "body": body,
      "createdTime": createdTime,
    });
  }
}
