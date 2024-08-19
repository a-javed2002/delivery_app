import 'package:delivery/database/local_database.dart';

class DashboardController {
  final LocalDatabase localDb = LocalDatabase.instance;

  Future<Map<String, dynamic>> fetchDashboardData() async {
    final db = await localDb.database;

    final stocks = await db.query('stocks');
    final retailers = await db.query('retailers');
    final invoices = await db.query('invoices');

    // Ensure that 'quantity' is cast to an int
    final totalStock = stocks.fold<int>(0, (sum, item) {
      final quantity = item['quantity'] as int? ?? 0; // Cast and default to 0 if null
      return sum + quantity;
    });

    final remainingStock = totalStock; // Adjust logic as needed
    final totalRetailers = retailers.length;
    final visitedRetailers = retailers.where((r) => r['visited'] == 1).length;

    return {
      'totalStock': totalStock,
      'remainingStock': remainingStock,
      'totalRetailers': totalRetailers,
      'visitedRetailers': visitedRetailers,
      'retailers': retailers,
    };
  }
}
