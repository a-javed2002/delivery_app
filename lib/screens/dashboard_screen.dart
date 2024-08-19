import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:delivery/controllers/dashboard_controller.dart';
import 'package:delivery/routes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController dashboardController = DashboardController();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Set<Marker> _markers = {};
  LatLng _currentPosition = LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _fetchDataAndSetupMap();
  }

  void _initializeNotifications() {
    final InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _fetchDataAndSetupMap() async {
    final data = await dashboardController.fetchDashboardData();
    final List<dynamic> retailers = data['retailers'];
    _currentPosition = await _getCurrentPosition();
    _markers = retailers.map<Marker>((retailer) {
      final position = LatLng(retailer['latitude'], retailer['longitude']);
      return Marker(
        markerId: MarkerId(retailer['id'].toString()),
        position: position,
        infoWindow: InfoWindow(
          title: retailer['name'],
          snippet: 'Tap to view details',
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.retailerDetail,
              arguments: retailer,
            );
          },
        ),
        icon: BitmapDescriptor.defaultMarker,
      );
    }).toSet();

    _checkProximity(retailers);
    setState(() {});
  }

  Future<LatLng> _getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }

  void _checkProximity(List<dynamic> retailers) async {
    for (var retailer in retailers) {
      final retailerPosition = LatLng(retailer['latitude'], retailer['longitude']);
      final distance = Geolocator.distanceBetween(
        _currentPosition.latitude,
        _currentPosition.longitude,
        retailerPosition.latitude,
        retailerPosition.longitude,
      );

      if (distance <= 500) {
        _showNotification(retailer);
      }
    }
  }

  void _showNotification(dynamic retailer) {
    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        channelDescription: 'This is a channel for notifications',
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('notification'),
        vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
      ),
    );

    flutterLocalNotificationsPlugin.show(
      0,
      'Nearby Retailer',
      'You are within 500 meters of ${retailer['name']}',
      notificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: FutureBuilder(
        future: dashboardController.fetchDashboardData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final data = snapshot.data as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Stock: ${data['totalStock']}'),
              Text('Remaining Stock: ${data['remainingStock']}'),
              Text('Retailers Visited: ${data['visitedRetailers']}'),
              Text('Total Retailers: ${data['totalRetailers']}'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.stockList);
                },
                child: Text('View Stock List'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.retailerList);
                },
                child: Text('View Retailer List'),
              ),
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition,
                    zoom: 12,
                  ),
                  markers: _markers,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
