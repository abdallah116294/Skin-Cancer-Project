import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/features/search/domain/entities/get_news_data_entities.dart';

abstract class SearchRepository {
  Future<Either<Failure, GetNewsData>> getSearch(String item);
}
