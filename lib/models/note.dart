class Note {
  Note({this.id, required this.title, required this.content});

  final int? id;
  final String title;
  final String content;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}
