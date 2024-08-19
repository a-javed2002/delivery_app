import 'package:flutter/material.dart';
import 'package:delivery/controllers/login_controller.dart';
import 'package:delivery/routes.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool success = await loginController.login(
                  usernameController.text,
                  passwordController.text,
                );
                if (success) {
                  Navigator.pushReplacementNamed(context, Routes.dashboard);
                } else {
                  // Handle login failure
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
