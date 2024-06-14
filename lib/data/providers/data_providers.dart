import 'dart:async';

import 'package:finnhub_project/services/web_socket_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timerStocksProvider = StateProvider<Timer?>((ref) => null);

final websocketsProvider =
    StateProvider<List<WebSocketService>?>((ref) => null);
