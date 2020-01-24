class NotesForListing {
  String noteID;
  String noteTitle;
  DateTime createDataTime;
  DateTime latestEditDateTime;

  NotesForListing({
    this.noteID,
    this.noteTitle,
    this.createDataTime,
    this.latestEditDateTime,
  });

  factory NotesForListing.fromJson(Map<String, dynamic> item) {
    return NotesForListing(
      noteID: item['noteID'],
      noteTitle: item['noteTitle'],
      createDataTime: DateTime.parse(item['createDateTime']),
      latestEditDateTime: item['latestEditDateTime'] != null
          ? DateTime.parse(item['latestEditDateTime'])
          : null,
    );
  }
}
