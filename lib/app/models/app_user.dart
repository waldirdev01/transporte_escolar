enum UserType {
  newUser,
  coordinator,
  monitor,
  admin,
  schoolMember,
  tcb,
}

extension UserTypeExtension on UserType {
  String get string {
    switch (this) {
      case UserType.newUser:
        return 'newUser';
      case UserType.coordinator:
        return 'coord';
      case UserType.monitor:
        return 'monitor';
      case UserType.admin:
        return 'admin';
      case UserType.schoolMember:
        return 'schoolMember';
      case UserType.tcb:
        return 'tcb';
    }
  }

  static UserType fromString(String str) {
    switch (str) {
      case 'newUser':
        return UserType.newUser;
      case 'coord':
        return UserType.coordinator;
      case 'monitor':
        return UserType.monitor;
      case 'admin':
        return UserType.admin;
      case 'schoolMember':
        return UserType.schoolMember;
      case 'tcb':
        return UserType.tcb;
      default:
        throw ArgumentError('Invalid user type: $str');
    }
  }
}

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
