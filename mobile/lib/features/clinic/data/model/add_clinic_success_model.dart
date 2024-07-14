class AddClinicSuccessModel {
  bool? isSucceeded;
  String? message;

  AddClinicSuccessModel({this.isSucceeded, this.message});

  AddClinicSuccessModel.fromJson(Map<String, dynamic> json) {
    isSucceeded = json['isSucceeded'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSucceeded'] = isSucceeded;
    data['message'] = message;
    return data;
  }
}
