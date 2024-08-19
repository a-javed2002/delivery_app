import 'dart:convert';

class Payment {
  final int id;
  final int invoiceId;
  final double amount;

  Payment({
    required this.id,
    required this.invoiceId,
    required this.amount,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json['id'],
    invoiceId: json['invoiceId'],
    amount: json['amount'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'invoiceId': invoiceId,
    'amount': amount,
  };
}
