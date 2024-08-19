import 'package:flutter/material.dart';

class VisitedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, color: Colors.blue, size: 80),
            SizedBox(height: 20),
            Text(
              "Retailer Marked as Visited",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back to Retailer List"),
            )
          ],
        ),
      ),
    );
  }
}
