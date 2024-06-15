import 'dart:async';

import 'package:finnhub_project/data/datasources/google_oauth_client.dart';
import 'package:finnhub_project/data/repositories/google_oauth_repository.dart';
import 'package:finnhub_project/services/web_socket_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timerStocksProvider = StateProvider<Timer?>((ref) => null);

var googleAuthORepositoryProvider = Provider<GoogleAuthORepository>(
  (ref) => GoogleAuthORepository(
    googleAuthOClient: GoogleAuthOClient(),
  ),
);

final websocketsProvider = StateProvider<WebSocketService?>((ref) => null);
