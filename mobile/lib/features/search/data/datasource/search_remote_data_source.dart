
import 'package:mobile/core/api/dio_helper.dart';
import 'package:mobile/features/search/data/model/news_data_model.dart';

abstract class SearchRemoteDataSource {
  Future<NewsDataModel> searchData(String item);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final DioHepler dioHepler;
  SearchRemoteDataSourceImpl({required this.dioHepler});
  @override
  Future<NewsDataModel> searchData(String item) async {
    var response = await dioHepler.getSearchItems(item);
    return NewsDataModel.fromjson(response);
  }
}
