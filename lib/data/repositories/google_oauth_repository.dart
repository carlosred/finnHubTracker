import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../datasources/google_oauth_client.dart';

class GoogleAuthORepository {
  final GoogleAuthOClient googleAuthOClient;

  GoogleAuthORepository({
    required this.googleAuthOClient,
  });

  Future<User?> loginWithGoogle() async {
    User? result;
    try {
      result = await googleAuthOClient.loginWithGoogle();
    } catch (e) {
      debugPrint('error: $e');
    }

    return result;
  }
}
