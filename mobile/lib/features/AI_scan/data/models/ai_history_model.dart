class AiHistoryModel {
  AiHistoryModel({
    required this.imagePath,
    required this.result,
    required this.date,
    required this.userId,
    required this.diagnosis,
    required this.user,
    required this.id,
  });

  final String? imagePath;
  final String? result;
  final DateTime? date;
  final String? userId;
  final String? diagnosis;
  final dynamic user;
  final int? id;

  factory AiHistoryModel.fromJson(Map<String, dynamic> json){
    return AiHistoryModel(
      imagePath: json["imagePath"],
      result: json["result"],
      date: DateTime.tryParse(json["date"] ?? ""),
      userId: json["userId"],
      diagnosis: json["diagnosis"],
      user: json["user"],
      id: json["id"],
    );
  }

}
