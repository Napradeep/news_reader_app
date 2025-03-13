import 'package:hive/hive.dart';

part 'new_model.g.dart';

@HiveType(typeId: 0)
class Newmodel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String url;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final String source;

  @HiveField(5)
  final String content;

  @HiveField(6)
  final String publishedAt;

  Newmodel({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.source,
    required this.publishedAt,
    required this.content,
  });

  factory Newmodel.fromJson(Map<String, dynamic> json) {
    return Newmodel(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      source: json['source']['name'] ?? 'Unknown',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'imageUrl': imageUrl,
      'source': source,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}
