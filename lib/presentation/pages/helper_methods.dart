import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Text('Login Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Login'),
        ),
      ),
    );
  }
}
