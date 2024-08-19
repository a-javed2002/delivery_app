import 'package:delivery/data/models/stock_model.dart';
import 'package:flutter/material.dart';
import 'package:delivery/controllers/stock_controller.dart';

class StockListScreen extends StatelessWidget {
  final StockController stockController = StockController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stock List')),
      body: FutureBuilder(
        future: stockController.fetchStocks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final stocks = snapshot.data as List<Stock>;
          return ListView.builder(
            itemCount: stocks.length,
            itemBuilder: (context, index) {
              final stock = stocks[index];
              return ListTile(
                title: Text(stock.name),
                subtitle: Text('Quantity: ${stock.quantity}'),
              );
            },
          );
        },
      ),
    );
  }
}
