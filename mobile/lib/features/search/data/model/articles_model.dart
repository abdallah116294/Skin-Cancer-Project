
import 'package:mobile/features/search/data/model/source_model.dart';

import '../../domain/entities/articles_entities.dart';

class ArticlesModle extends Articles {
  ArticlesModle(
      {required super.source,
      required super.auther,
      required super.title,
      required super.description,
      required super.url,
      required super.urlToImage,
      required super.publishedAt,
      required super.content});
  factory ArticlesModle.fromJson(Map<String, dynamic> json) {
    return ArticlesModle(
      auther: json['auther'],
      content: json["content"],
      description: json["description"],
      publishedAt: json["publishedAt"],
      source:json["source"]!=null ? SourceModel.fromJson(json):null ,
      title: json["title"],
      url: json["json"],
      urlToImage: json["urlToImage"]
    );
  }
}
