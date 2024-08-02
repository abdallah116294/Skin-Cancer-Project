class UploadSuccessModel {
  final String message;

  UploadSuccessModel({required this.message});

  factory UploadSuccessModel.fromJson(Map<String, dynamic> json) =>
      UploadSuccessModel(message: json['message']);
}
