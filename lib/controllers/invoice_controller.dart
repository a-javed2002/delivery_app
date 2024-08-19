import 'package:delivery/data/models/invoice_model.dart';
import 'package:delivery/services/api_service.dart';

class InvoiceController {
  Future<List<Invoice>> fetchInvoicesByRetailer(int retailerId) async {
    try {
      final response = await ApiService.get('/retailers/$retailerId/invoices');
      return (response as List).map((data) => Invoice.fromJson(data)).toList();
    } catch (e) {
      print('Fetch invoices error: $e');
      return [];
    }
  }
}
