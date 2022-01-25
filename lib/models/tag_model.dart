import 'dart:convert';

Tag tagFromJson(String str) {
  final jsonData = json.decode(str);
  return Tag.fromJson(jsonData);
}

List<Tag> tagsFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Tag>.from(jsonData['tags'].map((postJsonString) => Tag.fromJson(postJsonString)));
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