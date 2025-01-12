class VehicleType {
  final String name;
  final String imageUrl;
  final int wheels;

  VehicleType({required this.name, required this.imageUrl, required this.wheels});

  // Factory constructor to create an instance from a JSON map
  factory VehicleType.fromJson(Map<String, dynamic> json) {
    return VehicleType(
      name: json['name'] ?? 'Unknown Name',
      imageUrl: json['imageUrl'] ?? '',
      wheels: json['wheels'] ?? 0,
    );
  }
}
