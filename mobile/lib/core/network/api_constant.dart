const int skinmodel = 1;
const int detectmodel = 2;

class ApiConstant {
  static const String baseUrl = 'http://skincancerv4.runasp.net';
  static const String loginEndPoint = '/api/account/login';
  static const String registerEndPoint = '/api/account/register';
  static const String confirmEmailEndPoint = "/api/account/confirmemail";
  static const String addRoleEndPoint = "/api/account/addrole";
  static const String forgetPasswordEndPoint = '/api/account/forgetpassword';
  static const String resetPasswordEndPoint = '/api/account/resetpassword';
  static const String createClinicEndPoint = "/api/clinic/createclinic";
  static const String getClinicByNameEndPoint = "/api/clinic/getclinicbyname";
  static const String deleteClinicEndPoint = "/api/clinic/deleteclinic";
  static const String getAllClinics = "/api/clinic/getallclinics";
  static const String getClinicByIDEndPoint = "/api/clinic/getclinicbyid";
  static const String patientBookScheduleEndPoint =
      "/api/schedule/patientbookschedule";
  static const String patientRateClinicEndPoint =
      "/api/clinic/patientrateclinic";
  static const String getClinicSchedulesclinicIdEndPoint =
      "/api/schedule/getclinicschedules";
  static const String getDoctorHasClinicEndPoint =
      "/api/clinic/isdoctorhasclinic";
  static const String updateClinic = "/api/clinic/updateclinic";
  static const String aiBasUrl = "http://18.214.13.65";
  static const String skinornotModel = "/predict/$skinmodel";
  static const String detectModel = "/predict/$detectmodel";
  static const String uploadAiResult = "/api/detection";
  static const String getAiResult = "/api/detection";
  static const String getPatinetAppointment =
      "/api/schedule/getpatientschedules";
  static const String getClinicAppointments =
      "/api/schedule/getclinicbookedschedules";
  static const String addDiagnosis = "/api/detection/adddiagnosis";
  static const String docCreateSchedule = "/api/schedule/doctorcreateschedule";
  static const String doctDetails = "/api/account/getdoctordetails";
  static const String patientDetails = "/api/account/getpatientdetails";
  static const String paymentOrder = "/api/payment/paymentorder";
}
