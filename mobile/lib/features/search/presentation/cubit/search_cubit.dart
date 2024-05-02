import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/error/failures.dart';
import 'package:mobile/features/search/domain/entities/get_news_data_entities.dart';
import 'package:mobile/features/search/domain/usecase/search_usecase.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.searchUseCase}) : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);
  final SearchUseCase searchUseCase;
  Future<void> getSearchResult(String item) async {
    Either<Failure, GetNewsData> searchresult =await searchUseCase(item);
    emit(searchresult.fold((failure) =>SearchStateError(msg: _mapFailureToMsg(failure)) , (searchreslut) =>SearchStateLoaded(getNewsData: searchreslut) ));
  }
  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "ServerFailure";
      case CacheFailure:
        return "CacheFailure";

      default:
        return "unexpectedError";
    }
  }
}
