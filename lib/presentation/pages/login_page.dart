import 'package:animate_do/animate_do.dart';
import 'package:finnhub_project/core/routes/routes.dart';
import 'package:finnhub_project/presentation/controllers/login_page_controller.dart';
import 'package:finnhub_project/utils/constants.dart';
import 'package:finnhub_project/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/enum.dart';
import '../widgets/login_button.dart';

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
        Navigator.of(context).pushNamed(Routes.homeRoute);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var loginPageController = ref.watch(loginPageControllerProvider);
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: Container(
            height: height,
            width: width,
            decoration: Styles.backgroundGradient,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeInLeft(
                  duration: const Duration(milliseconds: 1500),
                  child: const Text(
                    Constants.welcomeTxt,
                    style: Styles.textStyleTittle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                loginPageController.when(
                  data: (data) {
                    if (data != null) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: LoginButton(
                          ref: ref,
                          status: LoginStatus.success,
                        ),
                      );
                    } else {
                      return FadeInRight(
                        duration: const Duration(milliseconds: 1500),
                        child: LoginButton(
                          ref: ref,
                          status: LoginStatus.login,
                          onPressed: () async {
                            await ref
                                .read(loginPageControllerProvider.notifier)
                                .loginWithGoogle();
                          },
                        ),
                      );
                    }
                  },
                  error: (error, stack) => Text(
                    '${Constants.somethingWentWrongTxt} : ${error.toString()}',
                  ),
                  loading: () => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: LoginButton(
                      ref: ref,
                      status: LoginStatus.loading,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
