import 'package:delivery/data/database_helper.dart';
import 'package:delivery/data/models/payment_model.dart';

class PaymentController {
  final dbHelper = DatabaseHelper.instance;

  Future<void> makePayment(int invoiceId, double amountPaid) async {
    final db = await dbHelper.database;
    await db.insert('Payment', {
      'invoiceId': invoiceId,
      'amountPaid': amountPaid,
      'date': DateTime.now().toString(),
    });

    // Update invoice status
    await db.update('Invoice', {'isOpen': 0}, where: 'id = ?', whereArgs: [invoiceId]);
  }
}
