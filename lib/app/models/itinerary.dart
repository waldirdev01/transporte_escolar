class Itinerary {
  String? id;
  String code;
  String vehiclePlate;
  String driverName;
  String driverPhone;
  String driverLicence;
  int capacity;
  List<String>? studentIds;
  String shift;
  double kilometer;
  String? appUserId;
  String description;
  List<String>? schoolIds;
  String contract;
  String? importantAnnotation;

  Itinerary({
    this.id,
    required this.code,
    required this.vehiclePlate,
    required this.driverName,
    required this.capacity,
    required this.driverLicence,
    required this.driverPhone,
    required this.shift,
    required this.kilometer,
    required this.description,
    required this.contract,
    this.appUserId,
    this.importantAnnotation,
    this.schoolIds,
    this.studentIds,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'vehiclePlate': vehiclePlate,
        'studentIds': studentIds,
        'driverName': driverName,
        'capacity': capacity,
        'driverLicence': driverLicence,
        'driverPhone': driverPhone,
        'shift': shift,
        'kilometer': kilometer,
        'appUserId': appUserId,
        'description': description,
        'contract': contract,
        'schoolIds': schoolIds,
        'importantAnnotation': importantAnnotation,
      };

  factory Itinerary.fromJson(Map<String, dynamic> json) {
    return Itinerary(
      id: json['id'],
      code: json['code'],
      vehiclePlate: json['vehiclePlate'],
      studentIds: List<String>.from(
        json['studentIds'] ?? [],
      ),
      driverName: json['driverName'],
      capacity: json['capacity'],
      driverLicence: json['driverLicence'],
      driverPhone: json['driverPhone'],
      shift: json['shift'],
      kilometer: (json['kilometer'] as num).toDouble(),
      appUserId: json['appUserId'],
      description: json['description'],
      contract: json['contract'],
      schoolIds: List<String>.from(
        json['schoolIds'] ?? [],
      ),
      importantAnnotation: json['importantAnnotation'],
    );
  }
}
