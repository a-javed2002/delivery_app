import 'package:flutter/material.dart';

class FailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Operation Failed!', style: TextStyle(fontSize: 24, color: Colors.red)),
      ),
    );
  }
}
