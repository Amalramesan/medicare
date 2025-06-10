class DoctorModel {
  int id;
  int user;
  String name;
  String specialization;
  String hospital;
  bool availableToday;
  String imageUrl;

  DoctorModel({
    required this.id,
    required this.user,
    required this.name,
    required this.specialization,
    required this.hospital,
    required this.availableToday,
    required this.imageUrl,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'],
      user: json['user'],
      name: json['name'],
      specialization: json['specialization'],
      hospital: json['hospital'],
      availableToday: json['available_today'] == true,
      imageUrl: json['image'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'name': name,
      'specialization': specialization,
      'hospital': hospital,
      'availableToday': availableToday,
      'image': imageUrl,
    };
  }
}
