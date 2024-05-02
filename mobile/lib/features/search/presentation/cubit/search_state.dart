part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchStateIsloading extends SearchState {}

final class SearchStateLoaded extends SearchState {
  final GetNewsData getNewsData;
 const  SearchStateLoaded({required this.getNewsData});
}

final class SearchStateError extends SearchState {
  final String msg;
  const SearchStateError({required this.msg});
}
