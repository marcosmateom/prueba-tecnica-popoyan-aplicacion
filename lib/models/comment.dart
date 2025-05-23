class Comment {
  final int id;
  final String content;

  Comment({
    required this.id,
    required this.content,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as int,
      content: json['content'] as String,
    );
  }
}
