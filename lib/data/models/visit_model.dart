import 'dart:convert';

class Visit {
  final int id;
  final int retailerId;
  final DateTime date;

  Visit({
    required this.id,
    required this.retailerId,
    required this.date,
  });

  factory Visit.fromJson(Map<String, dynamic> json) => Visit(
    id: json['id'],
    retailerId: json['retailerId'],
    date: DateTime.parse(json['date']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'retailerId': retailerId,
    'date': date.toIso8601String(),
  };
}
