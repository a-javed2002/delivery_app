import 'dart:convert';

class SalesOrder {
  final int id;
  final int retailerId;
  final List<String> lineItems;

  SalesOrder({
    required this.id,
    required this.retailerId,
    required this.lineItems,
  });

  factory SalesOrder.fromJson(Map<String, dynamic> json) => SalesOrder(
    id: json['id'],
    retailerId: json['retailerId'],
    lineItems: List<String>.from(json['lineItems']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'retailerId': retailerId,
    'lineItems': lineItems,
  };
}
