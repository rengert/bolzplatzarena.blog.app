import 'dart:convert';

import 'package:bolzplatzarena.blog.app/services/loggin.util.dart';

Tag tagFromJson(String str) {
  try {
    final jsonData = json.decode(str);
    return Tag.fromJson(jsonData);
  } catch(error, stackTrace) {
    logger.e('Tag cannot be loaded', error, stackTrace);
    rethrow;
  }
}

List<Tag> tagsFromJson(String str) {
  try {
    final jsonData = json.decode(str);
    return List<Tag>.from(jsonData['tags'].map((postJsonString) => Tag.fromJson(postJsonString)));
  } catch(error, stackTrace) {
    logger.e('Tags cannot be loaded', error, stackTrace);
    return List<Tag>.empty();
  }
}

class Tag {
  Tag({required this.id, required this.title, required this.slug});

  final String id;
  final String title;
  final String slug;

  factory Tag.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as String;
    final title = data['title'] as String;
    final slug = data['slug'] as String;

    return Tag(id: id, title: title, slug: slug);
  }
}