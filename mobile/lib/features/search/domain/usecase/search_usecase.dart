import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/core/usecases/usecase.dart';
import 'package:mobile/features/search/domain/entities/get_news_data_entities.dart';
import 'package:mobile/features/search/domain/repository/search_repository.dart';
class SearchUseCase implements Usecases<GetNewsData, String> {
  final SearchRepository searchRepository;
  SearchUseCase({required this.searchRepository});
  @override
  Future<Either<Failure, GetNewsData>> call(params) =>
      searchRepository.getSearch(params);
}
