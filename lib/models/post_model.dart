import 'dart:convert';
import 'package:bolzplatzarena.blog.app/services/loggin.util.dart';

import 'block_model.dart';

Post postFromJson(String str) {
  try {
    final jsonData = json.decode(str);
    return Post.fromJson(jsonData);
  } catch(error, stackTrace) {
    logger.e('Post cannot be loaded', error, stackTrace);
    rethrow;
  }
}

List<Post> postsFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Post>.from(jsonData['posts'].map((postJsonString) => Post.fromJson(postJsonString)));
}

class Post {
  Post({
    required this.id,
    required this.title,
    required this.text,
    required this.blocks,
  });

  final String id;
  final String title;
  final String text;
  final List<Block> blocks;

  factory Post.fromJson(Map<String, dynamic> data) {
    final id = (data['slug'] ?? data['link']) as String;
    final title = data['title'] as String;
    final body = data['body'] != null ? (data['body'] as dynamic)['value'] : '';

    final blocks = data['blocks'] != null
      ? (data['blocks'] as List<dynamic>).map((e) => Block.fromJson(e)).toList()
        : List<Block>.empty();

    return Post(id: id, title: title, text: body, blocks: blocks.toList());
  }
}