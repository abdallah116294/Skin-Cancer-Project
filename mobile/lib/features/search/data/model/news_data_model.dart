import 'package:mobile/features/search/domain/entities/get_news_data_entities.dart';

import 'articles_model.dart';

class NewsDataModel extends GetNewsData {
  NewsDataModel(
      {required super.status,
      required super.totalResults,
      required super.articles});

  factory NewsDataModel.fromjson(Map<String, dynamic> json) {
    final List<dynamic>? articleList = json["articles"] as List<dynamic>?;
    List<ArticlesModle> articles = [];
    if (articleList != null) {
      articles = articleList
          .map((articleJson) => ArticlesModle.fromJson(articleJson))
          .toList();
    }
    return NewsDataModel(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: articles);
  }
}
