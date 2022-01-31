import 'package:bolzplatzarena.blog.app/models/navigation_item_model.dart';
import 'package:http/http.dart' as http;

String url = 'https://www.bolzplatzarena.net/api/sitemap';

Future<List<NavigationItem>> getNavigation() async{
  final response = await http.get(Uri.parse(url));
  return navigationFromJson(response.body)
      .where((element) => !element.link.startsWith("http"))
      .toList();
}
