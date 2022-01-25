import 'dart:convert';

import 'package:bolzplatzarena.blog.app/models/tag_model.dart';

Post postFromJson(String str) {
  final jsonData = json.decode(str);
  return Post.fromJson(jsonData);
}

List<Post> postsFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Post>.from(jsonData['posts'].map((postJsonString) => Post.fromJson(postJsonString)));
}

class Post {
  Post({
    required this.id,
    required this.date,
    required this.title,
    required this.text,
    required this.tags,
  });

  final DateTime date;
  final String id;
  final String title;
  final String text;
  final List<Tag> tags;

  factory Post.fromJson(Map<String, dynamic> data) {
    final title = data['title'] as String;
    final body = (data['body'] as dynamic)['value'];
    final id = data['link'] as String;
    final date = DateTime.parse(data['date'] as String);
    final tags = (data['tags'] as List<dynamic>)
        .map((e) => Tag.fromJson(e));

    return Post(id: id, date: date, title: title, text: body, tags: tags.toList());
  }
}