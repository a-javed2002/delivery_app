class DeliveryMan {
  final int id;
  final String username;
  final String password;

  DeliveryMan({
    required this.id,
    required this.username,
    required this.password,
  });

  factory DeliveryMan.fromJson(Map<String, dynamic> json) => DeliveryMan(
    id: json['id'],
    username: json['username'],
    password: json['password'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'password': password,
  };
}
