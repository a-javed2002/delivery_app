import 'package:flutter/material.dart';
import 'package:delivery/screens/splash_screen.dart';
import 'package:delivery/screens/login_screen.dart';
import 'package:delivery/screens/dashboard_screen.dart';
import 'package:delivery/screens/stock_list_screen.dart';
import 'package:delivery/screens/retailer_list_screen.dart';
import 'package:delivery/screens/retailer_detail_screen.dart';
import 'package:delivery/screens/delivery_screen.dart';
import 'package:delivery/screens/loader_screen.dart';
import 'package:delivery/screens/success_screen.dart';
import 'package:delivery/screens/fail_screen.dart';
import 'package:delivery/data/models/retailer_model.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String stockList = '/stockList';
  static const String retailerList = '/retailerList';
  static const String retailerDetail = '/retailerDetail';
  static const String delivery = '/delivery';
  static const String loader = '/loader';
  static const String success = '/success';
  static const String fail = '/fail';
}

class AppRoutes {
  static final routes = {
    Routes.splash: (context) => SplashScreen(),
    Routes.login: (context) => LoginScreen(),
    Routes.dashboard: (context) => DashboardScreen(),
    Routes.stockList: (context) => StockListScreen(),
    Routes.retailerList: (context) => RetailerListScreen(),
    Routes.retailerDetail: (context) => RetailerDetailScreen(
      retailer: ModalRoute.of(context)!.settings.arguments as Retailer,
    ),
    Routes.delivery: (context) => DeliveryScreen(),
    Routes.loader: (context) => LoaderScreen(),
    Routes.success: (context) => SuccessScreen(),
    Routes.fail: (context) => FailScreen(),
  };
}
