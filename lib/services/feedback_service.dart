import 'dart:convert';
import 'package:bolzplatzarena.blog.app/models/feedback_model.dart';
import 'package:bolzplatzarena.blog.app/services/base_service.dart';
import 'package:http/http.dart' as http;

String url = '${baseUrl()}/api/comment';
String commentsUrl = '${baseUrl()}/api/comments';


Future<List<Feedback>> getFeedbacks() async {
  final response = await http.get(Uri.parse(commentsUrl));
  return feedbacksFromJson(response.body);
}

Future<bool> sendFeedback(String slug, String name, String comment) async {
  if(!slug.startsWith("/blog/")) {
    slug = "/blog/" + slug;
  }

  var body = jsonEncode({
    'comment': comment,
    'name': name,
    'slug': slug,
  });

  return http.post(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "content-type":"application/json"
      },
      body: body
  ).then((http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400) {
      return false;
    }
    return true;
  });
}