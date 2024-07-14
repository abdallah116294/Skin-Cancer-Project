class ClinicModel {
  final dynamic id;
  final String name;
  final dynamic price;
  final String phone;
  final String address;
  final String image;
  final String description;
  final String date1;
  final String date2;
  final String date3;
  final String doctorName;

  ClinicModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.phone,
      required this.address,
      required this.image,
      required this.description,
      required this.date1,
      required this.date2,
      required this.date3,
      required this.doctorName});
  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    return ClinicModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      phone: json['phone'],
      address: json['address'],
      image: json['image'],
      description: json['description'],
      date1: json['date1'],
      date2: json['date2'],
      date3: json['date3'],
      doctorName: json['doctorName'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
  "id": id,
  "name": name,
  "price":price,
  "phone": phone,
  "address": address,
  "image": image,
  "description": description,
  "date1": date1,
  "date2": date2,
  "date3":date3,
  "doctorName": doctorName
};
  }
}
