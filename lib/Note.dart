class Note {

  final String title;
  final String description;
  final String id;
  final String date;

  Note({this.title, this.description, this.id, this.date});

  Note.fromMap(Map<String, dynamic>data, String id)
      :
        title=data["title"],
        description=data["description"],
        id=id,
        date=data["date"];
  Map<String, dynamic> toMap() {

    return {
      "title": title,
      "description": description,
      "date":date
    };

  }


}
