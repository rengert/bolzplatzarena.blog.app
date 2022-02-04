import 'package:bolzplatzarena.blog.app/models/post_model.dart';
import 'package:bolzplatzarena.blog.app/models/post_teaser_model.dart';
import 'package:http/http.dart' as http;

String url = 'http://localhost:5000/api/byslug';

Future<Post> getPost(String slug) async{
  final slash = slug.startsWith('/') ? '' : '/';
  final response = await http.get(Uri.parse('$url$slash$slug'));
  return postFromJson(response.body);
}

Future<List<Post>> getPosts() async{
  final response = await http.get(Uri.parse(url));
  return postsFromJson(response.body);
}

Future<List<PostTeaser>> getPostTeasers() async{
  final response = await http.get(Uri.parse(url));
  return postTeasersFromJson(response.body);
}