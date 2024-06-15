import 'package:finnhub_project/presentation/providers/presentation_providers.dart';
import 'package:finnhub_project/services/local_notifications_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      const List<String> scopes = <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ];

      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: scopes,
      );
      final googleAccount = _googleSignIn.signIn();

      final googleResponse = await googleAccount;
      final googleAuth = await googleResponse?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      state = AsyncData(userCredential.user);
    } catch (error, stack) {
      state = AsyncError(error, stack);
    }
  }
}
