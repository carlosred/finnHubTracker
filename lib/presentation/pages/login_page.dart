import 'package:finnhub_project/presentation/controllers/login_page_controller.dart';
import 'package:finnhub_project/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  void initState() {
    ref.listenManual(loginPageControllerProvider, (previous, next) {
      if (next.hasValue && next.value != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Text('Login Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await ref
                .read(loginPageControllerProvider.notifier)
                .loginWithGoogle();
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
