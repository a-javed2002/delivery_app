import 'package:delivery/data/models/stock_model.dart';
import 'package:delivery/services/api_service.dart';

class StockController {
  Future<List<Stock>> fetchStocks() async {
    try {
      final response = await ApiService.get('/stocks');
      return (response as List).map((data) => Stock.fromJson(data)).toList();
    } catch (e) {
      print('Stock fetch error: $e');
      return [];
    }
  }
}
