class ClinicInfoModel {
    ClinicInfoModel({
        required this.id,
        required this.availableDates,
        required this.name,
        required this.price,
        required this.phone,
        required this.address,
        required this.image,
        required this.description,
        required this.rate,
        required this.doctorId,
        required this.doctorName,
    });

    final int? id;
    final List<String> availableDates;
    final String? name;
    final double? price;
    final String? phone;
    final String? address;
    final String? image;
    final String? description;
    final int? rate;
    final String? doctorId;
    final String? doctorName;

    factory ClinicInfoModel.fromJson(Map<String, dynamic> json){ 
        return ClinicInfoModel(
            id: json["id"],
            availableDates: json["availableDates"] == null ? [] : List<String>.from(json["availableDates"]),
            name: json["name"],
            price: json["price"],
            phone: json["phone"],
            address: json["address"],
            image: json["image"],
            description: json["description"],
            rate: json["rate"],
            doctorId: json["doctorId"],
            doctorName: json["doctorName"],
        );
    }

}
