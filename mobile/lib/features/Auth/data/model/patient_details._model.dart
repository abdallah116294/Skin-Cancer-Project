class PatientDetails {
    PatientDetails({
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.phoneNumber,
    });

    final String? firstName;
    final String? lastName;
    final String? email;
    final String? phoneNumber;

    factory PatientDetails.fromJson(Map<String, dynamic> json){ 
        return PatientDetails(
            firstName: json["firstName"],
            lastName: json["lastName"],
            email: json["email"],
            phoneNumber: json["phoneNumber"],
        );
    }

}
