class AppUser {
  final String id;
  final String name;
  final String email;
  final String userType;
  final String phone;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.userType,
    required this.phone,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      userType: json['userType'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'userType': userType,
      'phone': phone,
    };
  }
}
