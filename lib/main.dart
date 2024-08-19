import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:delivery/routes.dart';
import 'package:delivery/controllers/sync_controller.dart';

void main() {
  runApp(MyApp());
  checkConnectivity(); // Check connectivity when the app starts
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Routes.splash,
      routes: AppRoutes.routes,
    );
  }
}

void checkConnectivity() async {
  final connectivity = Connectivity();
  final result = await connectivity.checkConnectivity();

  if (result != ConnectivityResult.none) {
    final syncController = SyncController();
    await syncController.syncDataToCloud();
  }
}
