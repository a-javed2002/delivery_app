class Invoice {
  final int id;
  final double amount;

  Invoice({
    required this.id,
    required this.amount,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
    };
  }
}
