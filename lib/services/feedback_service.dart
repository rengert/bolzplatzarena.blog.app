import 'package:http/http.dart' as http;

String url = 'https://www.bolzplatzarena.net/api/comment';

Future<bool> sendFeedback(String slug, String name, String comment) async {
  Map<String, String> body = <String, String>{};

  if(!slug.startsWith("/blog/")) {
    slug = "/blog/" + slug;
  }

  body["slug"] = slug;
  body["name"] = name;
  body["comment"] = comment;
  return http.post(Uri.parse(url), body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400) {
      return false;
    }
    return true;
  });
}