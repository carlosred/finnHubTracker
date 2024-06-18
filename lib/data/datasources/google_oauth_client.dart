import 'package:finnhub_project/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthOClient {
  Future<User?> loginWithGoogle() async {
    const List<String> scopes = <String>[
      Constants.email,
    ];

    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: scopes,
    );
    final googleAccount = googleSignIn.signIn();

    final googleResponse = await googleAccount;
    final googleAuth = await googleResponse?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return Future.value(userCredential.user);
  }
}
