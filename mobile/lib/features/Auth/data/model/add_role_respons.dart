class AddRoleRespons {
  final String? roleName;
  final String userName;

  AddRoleRespons({required this.roleName, required this.userName});
  factory AddRoleRespons.fromJson(Map<String, dynamic> json) {
    return AddRoleRespons(
      roleName: json['roleName'],
      userName: json['userName'],
    );
  }
  
}
