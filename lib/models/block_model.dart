class Block {
  Block({
    required this.id,
    required this.type,
    required this.body,
    this.rawCode,
    this.language
  });

  final String id;
  final String type;
  final String body;

  final String? rawCode;
  final String? language;

  factory Block.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as String;
    final type = data['type'] as String;
    final body = data['body'] != null ? (data['body'] as dynamic)['value'] : '';

    final rawCode = (data['rawCode'] != null) ? (data['rawCode'] as dynamic)['value'] : null;
    final language = (data['language'] != null) ? (data['language'] as dynamic)['value'] : null;

    return Block(id: id, type: type, body: body, rawCode: rawCode, language: language);
  }
}