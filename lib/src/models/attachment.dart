class Attachment {
  final String id;
  final String name;
  final int size;
  final String type;
  final String url;

  Attachment({
    required this.id,
    required this.name,
    required this.size,
    required this.type,
    required this.url,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'] as String,
      name: json['name'] as String,
      size: json['size'] as int,
      type: json['type'] as String,
      url: json['url'] as String,
    );
  }
}
