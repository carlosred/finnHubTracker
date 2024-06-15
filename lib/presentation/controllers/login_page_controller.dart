import 'package:finnhub_project/data/providers/data_providers.dart';
import 'package:finnhub_project/presentation/providers/presentation_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_page_controller.g.dart';

@Riverpod(keepAlive: true)
class LoginPageController extends _$LoginPageController {
  @override
  Future<User?> build() async {
    return null;
  }

  Future<void> loginWithGoogle() async {
    state = const AsyncLoading();
    try {
      var user =
          await ref.read(googleAuthORepositoryProvider).loginWithGoogle();
      state = AsyncData(user);
    } catch (error, stack) {
      state = AsyncError(error, stack);
    }
  }
}
