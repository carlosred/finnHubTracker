import 'package:finnhub_project/presentation/controllers/login_page_controller.dart';
import 'package:finnhub_project/presentation/pages/home_page.dart';
import 'package:finnhub_project/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Text('Login Page'),
      ),
      body: Container(
        height: height,
        width: width,
        decoration: Styles.backgroundGradient,
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Welcome to Finnhub Trades Tracker',
              style: Styles.textStyleTittle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Please login to continue',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              width: width * 0.8,
              height: height * 0.1,
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Styles.mainAppColor),
                ),
                onPressed: () async {
                  await ref
                      .read(loginPageControllerProvider.notifier)
                      .loginWithGoogle();
                },
                child: const Text(
                  'Login',
                  style: Styles.textStyleTittle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
