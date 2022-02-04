import 'dart:convert';

import 'package:http/http.dart' as http;

String url = 'https://www.bolzplatzarena.net/api/comment';

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