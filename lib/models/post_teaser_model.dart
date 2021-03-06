import 'dart:convert';

import 'package:bolzplatzarena.blog.app/models/tag_model.dart';
import 'package:bolzplatzarena.blog.app/services/loggin.util.dart';

List<PostTeaser> postTeasersFromJson(String str) {
  try {
    final jsonData = json.decode(str);
    return List<PostTeaser>.from(jsonData['posts'].map((postJsonString) => PostTeaser.fromJson(postJsonString)));
  } catch(error, stackTrace) {
    logger.e('Post teasers cannot be loaded', error, stackTrace);
    return List<PostTeaser>.empty();
  }
}

class PostTeaser {
  PostTeaser({
    required this.id,
    required this.date,
    required this.title,
    required this.text,
    required this.tags,
  });

  final String id;
  final DateTime date;
  final String title;
  final String text;
  final List<Tag> tags;

  factory PostTeaser.fromJson(Map<String, dynamic> data) {
    final id = data['link'] as String;
    final title = data['title'] as String;
    final body = (data['body'] as dynamic)['value'] ?? ""; // Just to play it save
    final date = DateTime.parse(data['date'] as String);

    final tags = (data['tags'] as List<dynamic>)
        .map((e) => Tag.fromJson(e));

    return PostTeaser(id: id,
        date: date,
        title: title,
        text: body,
        tags: tags.toList());
  }
}