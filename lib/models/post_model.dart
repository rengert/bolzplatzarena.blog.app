import 'dart:convert';

Post postFromJson(String str) {
  final jsonData = json.decode(str);
  return Post.fromJson(jsonData);
}

List<Post> postsFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Post>.from(jsonData['posts'].map((postJsonString) => Post.fromJson(postJsonString)));
}

class Post {
  Post({required this.id, required this.date, required this.title});

  final DateTime date;
  final String id;
  final String title;

  factory Post.fromJson(Map<String, dynamic> data) {
    final title = data['title'] as String;
    final id = data['link'] as String;
    final date= DateTime.parse(data['date'] as String);

    return Post(id: id, date: date, title: title);
  }
}