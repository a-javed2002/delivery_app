import 'package:delivery/database/local_database.dart';
import 'package:delivery/services/api_service.dart';

class SyncController {
  final LocalDatabase localDb = LocalDatabase.instance;

  Future<void> syncDataToCloud() async {
    final db = await localDb.database;

    final stocks = await db.query('stocks');
    final retailers = await db.query('retailers');
    final invoices = await db.query('invoices');

    final data = {
      'stocks': stocks,
      'retailers': retailers,
      'invoices': invoices,
    };

    await ApiService.syncData(data);
  }
}
