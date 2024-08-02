class SelectedClinicModel {
    SelectedClinicModel({
        required this.patientId,
        required this.patientName,
        required this.date,
        required this.clinicName,
        required this.scheduleId,
    });

    final String? patientId;
    final String? patientName;
    final DateTime? date;
    final String? clinicName;
    final int? scheduleId;

    factory SelectedClinicModel.fromJson(Map<String, dynamic> json){ 
        return SelectedClinicModel(
            patientId: json["patientId"],
            patientName: json["patientName"],
            date: DateTime.tryParse(json["date"] ?? ""),
            clinicName: json["clinicName"],
            scheduleId: json["scheduleId"],
        );
    }

}
