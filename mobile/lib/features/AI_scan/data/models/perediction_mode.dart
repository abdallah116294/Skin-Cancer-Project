
class PeredictionModel {
  final String prediction;
  PeredictionModel({required this.prediction});
  factory PeredictionModel.fromJson(Map<String, dynamic> json) {
    return PeredictionModel(prediction:json ['prediction']);
  }
}
