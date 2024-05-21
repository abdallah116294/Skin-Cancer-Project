class UpdateClinicModel {
  UpdateClinicModel({
    required this.id,
    required this.name,
    required this.price,
    required this.phone,
    required this.address,
    required this.image,
    required this.description,
  });

  final int? id;
  final String? name;
  final int? price;
  final String? phone;
  final String? address;
  final String? image;
  final String? description;

  factory UpdateClinicModel.fromJson(Map<String, dynamic> json){
    return UpdateClinicModel(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      phone: json["phone"],
      address: json["address"],
      image: json["image"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "phone": phone,
    "address": address,
    "image": image,
    "description": description,
  };

}