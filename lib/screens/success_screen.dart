import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Operation Successful!', style: TextStyle(fontSize: 24, color: Colors.green)),
      ),
    );
  }
}
