// class ClinicSchedualModel {
// final  String date;
// final  bool isBooked;
// final String? patientId;

//   ClinicSchedualModel({required this.date, required this.isBooked,  this.patientId});

//   factory ClinicSchedualModel.fromJson(Map<String, dynamic> json) {
//     return ClinicSchedualModel(
//       date: json['data'],
//       isBooked: json['isBooked'],
//       patientId: json['patientId']
//     );
//   }
// }
class ClinicSchedualModel {
  final String date;
  final bool isBooked;
  final String? patientId; // Make patientId nullable

  ClinicSchedualModel({
    required this.date,
    required this.isBooked,
    this.patientId, // Nullable
  });

  factory ClinicSchedualModel.fromJson(Map<String, dynamic> json) {
    return ClinicSchedualModel(
      date: json['date'],
      isBooked: json['isBooked'],
      patientId: json['patientId'], // No default value needed
    );
  }
}

