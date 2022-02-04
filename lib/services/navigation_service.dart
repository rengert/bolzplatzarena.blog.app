import 'package:bolzplatzarena.blog.app/models/navigation_item_model.dart';
import 'package:http/http.dart' as http;

import 'base_service.dart';

String url = '${baseUrl()}/api/sitemap';

Future<List<NavigationItem>> getNavigation() async{
  final response = await http.get(Uri.parse(url));
  return navigationFromJson(response.body)
      .where((element) => !element.link.startsWith("http"))
      .toList();
}
