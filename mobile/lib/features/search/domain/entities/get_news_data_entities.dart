import 'package:equatable/equatable.dart';

import 'articles_entities.dart';

class GetNewsData extends Equatable {
  final String status;
 final int totalResults;
  List<Articles>? articles;
  GetNewsData(
      {required this.status,
      required this.totalResults,
      required this.articles});
  @override
 
  List<Object?> get props => [
    status,
    totalResults,
    articles,
  ];
}
