class OrderRegisterationModel {
  int id;
  OrderRegisterationModel({required this.id});
  factory OrderRegisterationModel.fromJson(Map<String, dynamic> json) {
    return OrderRegisterationModel(id: json['id']);
  }
  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
