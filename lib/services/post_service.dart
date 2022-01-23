import 'package:http/http.dart' as http;
import 'package:reminder/models/post_model.dart';

String url = 'https://www.bolzplatzarena.net/api/byslug/';

Future<Post> getPost(String slug) async{
  final response = await http.get(Uri.parse('$url$slug'));
  return postFromJson(response.body);
}

Future<List<Post>> getPosts() async{
  final response = await http.get(Uri.parse(url));
  return postsFromJson(response.body);
}