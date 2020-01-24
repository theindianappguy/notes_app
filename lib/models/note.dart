class Note {
  String noteID;
  String noteTitle;
  String noteContent;
  DateTime createDataTime;
  DateTime latestEditDateTime;

  Note({
    this.noteID,
    this.noteTitle,
    this.noteContent,
    this.createDataTime,
    this.latestEditDateTime,
  });

  factory Note.fromJson(Map<String,dynamic> item){
    return Note(
      noteID: item['noteID'],
      noteTitle: item['noteTitle'],
      noteContent: item['noteContent'],
      createDataTime: DateTime.parse(item['createDateTime']),
      latestEditDateTime: item['latestEditDateTime'] != null
          ? DateTime.parse(item['latestEditDateTime'])
          : null,
    );
  }

}