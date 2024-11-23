class Note {
  int? id;
  String title;
  String content;

  Note({this.id, required this.title, required this.content});

  Note.empty()
      : id = null,
        title = '',
        content = '';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}
