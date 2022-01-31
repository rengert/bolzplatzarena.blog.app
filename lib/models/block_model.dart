class Block {
  Block({
    required this.id,
    required this.type,
    required this.body,
  });

  final String id;
  final String type;
  final String body;

  factory Block.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as String;
    final type = data['type'] as String;
    final body = (data['body'] as dynamic)['value'];

    return Block(id: id, type: type, body: body);
  }
}