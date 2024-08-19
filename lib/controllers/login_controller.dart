import 'package:delivery/services/api_service.dart';
import 'package:delivery/database/local_database.dart';

class LoginController {
  final LocalDatabase localDb = LocalDatabase.instance;

  Future<bool> login(String username, String password) async {
    try {
      // Assuming login is successful
      final success = true;

      if (success) {
        await seedStaticData();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  Future<void> seedStaticData() async {
    final db = await localDb.database;

    // Insert static data into stock table
    await db.insert('stocks', {'id': 1, 'name': 'Stock 1', 'quantity': 100});
    await db.insert('stocks', {'id': 2, 'name': 'Stock 2', 'quantity': 200});

    // Insert static data into retailers table
    await db.insert('retailers', {
      'id': 1,
      'name': 'Retailer 1',
      'latitude': 12.34,
      'longitude': 56.78,
      'visited': 0
    });
    await db.insert('retailers', {
      'id': 2,
      'name': 'Retailer 2',
      'latitude': 23.45,
      'longitude': 67.89,
      'visited': 0
    });

    // Insert static data into invoices table
    await db.insert('invoices', {'id': 1, 'amount': 250.00});
    await db.insert('invoices', {'id': 2, 'amount': 150.00});
  }
}
