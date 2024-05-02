import 'package:mobile/features/search/domain/entities/source_entities.dart';

class SourceModel extends Source {
  SourceModel({required super.id, required super.name});
  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json["id"],
      name: json["name"],
    );
  }
}
