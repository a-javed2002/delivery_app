import 'package:delivery/data/models/retailer_model.dart';
import 'package:flutter/material.dart';
import 'package:delivery/controllers/retailer_controller.dart';
import 'package:delivery/routes.dart';

class RetailerListScreen extends StatelessWidget {
  final RetailerController retailerController = RetailerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Retailer List')),
      body: FutureBuilder(
        future: retailerController.fetchRetailers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final retailers = snapshot.data as List<Retailer>;
          return ListView.builder(
            itemCount: retailers.length,
            itemBuilder: (context, index) {
              final retailer = retailers[index];
              return ListTile(
                title: Text(retailer.name),
                subtitle: Text('Latitude: ${retailer.latitude}, Longitude: ${retailer.longitude}'),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.retailerDetail,
                    arguments: retailer,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
