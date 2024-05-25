class SelectedClinicModel {
    SelectedClinicModel({
        required this.id,
        required this.name,
        required this.date,
        required this.clinicName,
        required this.userId,
    });

    final int? id;
    final String? name;
    final DateTime? date;
    final String? clinicName;
    final String? userId;

    factory SelectedClinicModel.fromJson(Map<String, dynamic> json){ 
        return SelectedClinicModel(
            id: json["id"],
            name: json["name"],
            date: DateTime.tryParse(json["date"] ?? ""),
            clinicName: json["clinicName"],
            userId: json["userId"],
        );
    }

}
