import 'package:equatable/equatable.dart';
import 'package:mobile/features/search/domain/entities/source_entities.dart';

class Articles extends Equatable {
  Source? source;
  String? auther;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  Articles({
    required this.source,
    required this.auther,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  @override
  List<Object?> get props => [
        source,
        auther,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content
      ];
}
