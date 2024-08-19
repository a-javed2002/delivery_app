class Stock {
  final int id;
  final String name;
  final int quantity;

  Stock({
    required this.id,
    required this.name,
    required this.quantity,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
    };
  }
}
