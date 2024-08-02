class DoctorDetails {
    DoctorDetails({
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.phoneNumber,
        required this.doctorHasClinic,
        required this.yearsOfExperiences,
    });

    final String? firstName;
    final String? lastName;
    final String? email;
    final String? phoneNumber;
    final bool? doctorHasClinic;
    final int? yearsOfExperiences;

    factory DoctorDetails.fromJson(Map<String, dynamic> json){ 
        return DoctorDetails(
            firstName: json["firstName"],
            lastName: json["lastName"],
            email: json["email"],
            phoneNumber: json["phoneNumber"],
            doctorHasClinic: json["doctorHasClinic"],
            yearsOfExperiences: json["yearsOfExperiences"],
        );
    }

}
