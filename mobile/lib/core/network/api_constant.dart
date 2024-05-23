const int skinmodel = 1;
const int detectmodel = 2;
class ApiConstant {
  static const String baseUrl = 'http://skincancerdetectionapiv2.runasp.net';
  static const String loginEndPoint = '/api/Account/Login';
  static const String registerEndPoint = '/api/Account/Register';
  static const String confirmEmailEndPoint = "/api/Account/ConfirmEmail";
  static const String addRoleEndPoint = "/api/Account/AddRole";
  static const String forgetPasswordEndPoint = '/api/Account/ForgetPassword';
  static const String resetPasswordEndPoint = '/api/Account/ResetPassword';
  static const String createClinicEndPoint = "/api/Clinic/CreateClinic";
  static const String getClinicByNameEndPoint = "/api/Clinic/GetClinicByName";
  static const String deleteClinicEndPoint = "/api/Clinic/DeleteClinic";
  static const String getAllClinics = "/api/Clinic/GetAllClinics";
  static const String getClinicByIDEndPoint = "/api/Clinic/GetClinicById";
  static const String patientBookScheduleEndPoint =
      "/api/Schedule/PatientBookSchedule";
  static const String patientRateClinicEndPoint =
      "/api/Clinic/PatientRateClinic";
  static const String getClinicSchedulesclinicIdEndPoint =
      "/api/Schedule/GetClinicSchedules";
  static const String getDoctorHasClinicEndPoint =
      "/api/Clinic/IsDoctorHasClinic";
  static const String updateClinic =
      "/api/Clinic/UpdateClinic";
    static const String aiBasUrl =
      "http://18.214.13.65";
  static const String skinornotModel = "/predict/$skinmodel";
  static const String detectModel = "/predict/$detectmodel";    
}
