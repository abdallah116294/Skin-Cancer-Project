class PatientBookSuccess {
  bool? isSucceeded;
  String? message;
  PatientBookSuccess({required this.isSucceeded, required this.message});
  factory PatientBookSuccess.fromJson(Map<String, dynamic> json) {
    return PatientBookSuccess(
        isSucceeded: json['isSucceeded'], message: json['message']);
  }
}
