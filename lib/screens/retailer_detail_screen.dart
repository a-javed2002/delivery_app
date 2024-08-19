import 'package:delivery/routes.dart';
import 'package:flutter/material.dart';
import 'package:delivery/controllers/retailer_controller.dart';
import 'package:delivery/controllers/invoice_controller.dart';
import 'package:delivery/data/models/retailer_model.dart';
import 'package:delivery/data/models/invoice_model.dart';

class RetailerDetailScreen extends StatelessWidget {
  final Retailer retailer;
  final RetailerController retailerController = RetailerController();
  final InvoiceController invoiceController = InvoiceController();

  RetailerDetailScreen({required this.retailer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(retailer.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Retailer Info:'),
          Text('Latitude: ${retailer.latitude}'),
          Text('Longitude: ${retailer.longitude}'),
          Text('Visited: ${retailer.visited ? 'Yes' : 'No'}'),
          SizedBox(height: 20),
          Text('Open Invoices:'),
          FutureBuilder(
            future: invoiceController.fetchInvoicesByRetailer(retailer.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              final invoices = snapshot.data as List<Invoice>;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: invoices.length,
                itemBuilder: (context, index) {
                  final invoice = invoices[index];
                  return ListTile(
                    title: Text('Invoice #${invoice.id}'),
                    subtitle: Text('Amount: \$${invoice.amount}'),
                  );
                },
              );
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              retailerController.updateRetailerVisitStatus(retailer.id, true);
              Navigator.pushNamed(context, Routes.delivery);
            },
            child: Text('Mark as Visited and Proceed'),
          ),
        ],
      ),
    );
  }
}
