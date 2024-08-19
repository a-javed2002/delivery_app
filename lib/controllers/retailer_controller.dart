import 'package:delivery/data/models/retailer_model.dart';
import 'package:delivery/services/api_service.dart';

class RetailerController {
  Future<List<Retailer>> fetchRetailers() async {
    try {
      final response = await ApiService.get('/retailers');
      return (response as List).map((data) => Retailer.fromJson(data)).toList();
    } catch (e) {
      print('Retailer fetch error: $e');
      return [];
    }
  }

  Future<void> updateRetailerVisitStatus(int id, bool visited) async {
    try {
      await ApiService.post('/retailers/$id/update', {'visited': visited});
    } catch (e) {
      print('Update retailer status error: $e');
    }
  }
}
