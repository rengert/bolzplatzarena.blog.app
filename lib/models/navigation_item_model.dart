import 'dart:convert';

List<NavigationItem> navigationFromJson(String str) {
  final jsonData = json.decode(str);
  return List<NavigationItem>.from(jsonData.map((jsonString) => NavigationItem.fromJson(jsonString)));
}

class NavigationItem {
  NavigationItem(this.id, this.link, this.title);

  final String id;
  final String link;
  final String title;

  factory NavigationItem.fromJson(dynamic json) {
    final id =  json["id"] as String;
    final link =  json["link"] as String;
    final title = json ["title"] as String;

    return NavigationItem(id, link, title);
  }
}