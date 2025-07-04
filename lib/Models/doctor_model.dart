class DoctorModel {
  final int id;
  final int user;
  final String name;
  final String specialization;
  final String hospital;
  final bool availableToday;
  final String imageUrl;

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
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      user: json['user'] is int
          ? json['user']
          : int.tryParse(json['user'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      specialization: json['specialization']?.toString() ?? '',
      hospital: json['hospital']?.toString() ?? '',
      availableToday: json['available_today'] == true,
      imageUrl: json['image']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'name': name,
      'specialization': specialization,
      'hospital': hospital,
      'available_today': availableToday,
      'image': imageUrl,
    };
  }
}
