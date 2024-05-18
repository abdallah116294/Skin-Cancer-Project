class UserModel {
  final String message;
  final bool isAuthenticated;
  final String userName;
  final String email;
  final List<String> roles;
  final String token;
  final String expireOn;

  UserModel(
      {required this.message,
      required this.isAuthenticated,
      required this.userName,
      required this.email,
      required this.roles,
      required this.token,
      required this.expireOn});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        message: json['message'],
        isAuthenticated: json['isAuthenticated'],
        userName: json['userName'],
        email: json['email'],
        roles: json['roles'].cast<String>(),
        token: json['token'],
        expireOn: json['expireOn']);
  }
}
