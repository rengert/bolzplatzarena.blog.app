import 'dart:collection';
import 'dart:convert';

List<Feedback> feedbacksFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Feedback>.from(jsonData.map((data) =>  Feedback.fromJson(data)));
}

class Feedback {
  Feedback({
    required this.author,
    required this.created,
    required this.comment,
  });

  final String author;
  final DateTime created;
  final String comment;

  factory Feedback.fromJson(LinkedHashMap data) {
    final author = data['author'] as String;
    final created = DateTime.parse(data['created'] as String);
    final comment = data['body'] as String;

    return Feedback(author: author, created: created, comment: comment);
  }
}