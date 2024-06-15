import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/local_notifications_service.dart';

final trendingStocksProvider = StateProvider<List<String>>((ref) => [
      "AAPL",
      "AMZN",
      "BINANCE:BTCUSDT",
      "IC MARKETS:1",
      "MSFT",
    ]);

final stockSelectedToBeNotified =
    StateProvider<Map<String, double>>((ref) => {});

final stocksPreviousPrices = StateProvider<Map<String, double>>((ref) => {});

final stockscurrentPrices = StateProvider<Map<String, double>>((ref) => {});

final notificationServiceProvider = StateProvider<LocalNotificationService>(
    (ref) => LocalNotificationService());
