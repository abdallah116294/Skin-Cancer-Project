class PaymentRequsetModel {
  String token;
  PaymentRequsetModel({required this.token});
  factory PaymentRequsetModel.fromJson(Map<String, dynamic> json) {
    return PaymentRequsetModel(token: json["token"]);
  }
  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
