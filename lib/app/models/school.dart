class School {
  String? id, appUserId;
  List<String>? studentsId;
  List<String>? itineraiesId;
  String name,
      phone,
      inep,
      principalName,
      principalRegister,
      secretaryName,
      secretaryRegister,
      type;

  School({
    this.id,
    required this.name,
    required this.phone,
    required this.inep,
    required this.principalName,
    required this.principalRegister,
    required this.secretaryName,
    required this.secretaryRegister,
    required this.type,
    this.studentsId,
    this.appUserId,
    List<String>? itineraiesId,
  }) : itineraiesId = itineraiesId ?? [];

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      inep: json['inep'],
      principalName: json['principalName'],
      principalRegister: json['principalRegister'],
      secretaryName: json['secretaryName'],
      secretaryRegister: json['secretaryRegister'],
      type: json['type'],
      studentsId: List<String>.from(
        json['students'] ?? [],
      ),
      itineraiesId: List<String>.from(
        json['itineraiesId'] ?? [],
      ),
      appUserId: json['appUserId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'inep': inep,
      'principalName': principalName,
      'principalRegister': principalRegister,
      'secretaryName': secretaryName,
      'secretaryRegister': secretaryRegister,
      'students': studentsId,
      'itineraiesId': itineraiesId,
      'appUserId': appUserId,
      'type': type,
    };
  }
}
