import 'dart:convert';

import 'package:bolzplatzarena.blog.app/services/loggin.util.dart';

List<NavigationItem> navigationFromJson(String str) {
  try {
    final jsonData = json.decode(str);
    return List<NavigationItem>.from(jsonData.map((jsonString) => NavigationItem.fromJson(jsonString)));
  } catch (error, stackTrace) {
    logger.e('Navigation cannot be loaded', error, stackTrace);
  }
  return List<NavigationItem>.empty();
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