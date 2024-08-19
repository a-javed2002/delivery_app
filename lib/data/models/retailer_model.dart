class Retailer {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final bool visited;

  Retailer({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.visited,
  });

  factory Retailer.fromJson(Map<String, dynamic> json) {
    return Retailer(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      visited: json['visited'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'visited': visited,
    };
  }
}
