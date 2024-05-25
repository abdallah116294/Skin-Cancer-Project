class CreateClinicModel {
  CreateClinicModel({
    required this.name,
    required this.price,
    required this.phone,
    required this.address,
    required this.image,
    required this.description,
    required this.doctorId,
    required this.doctorName,
  });

  final String? name;
  final int? price;
  final String? phone;
  final String? address;
  final String? image;
  final String? description;
  final String? doctorId;
  final String? doctorName;

  factory CreateClinicModel.fromJson(Map<String, dynamic> json){
    return CreateClinicModel(
      name: json["name"],
      price: json["price"],
      phone: json["phone"],
      address: json["address"],
      image: json["image"],
      description: json["description"],
      doctorId: json["doctorId"],
      doctorName: json["doctorName"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "phone": phone,
    "address": address,
    "image": image,
    "description": description,
    "doctorId": doctorId,
    "doctorName": doctorName,
  };

}
