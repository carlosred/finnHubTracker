import 'dart:convert';

import 'package:finnhub_project/domain/Models/stock/stock.dart';
import 'package:finnhub_project/domain/Models/stock_stream_item/stock_stream_item.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../services/local_notifications_service.dart';

final stockStreamRealProvider = StateProvider<Stream<dynamic>?>((ref) => null);

final trendingStocksProvider = StateProvider<List<String>>((ref) => [
      "AAPL",
      "AMZN",
      "BINANCE:BTCUSDT",
      "IC MARKETS:1",
      "MSFT",
    ]);

final stocksNotificationsProvider = StateProvider<List<Stock>>((ref) => []);

final stockSelectedToBeNotified =
    StateProvider<Map<String, double>>((ref) => {});

final stocksPreviousPrices = StateProvider<Map<String, double>>((ref) => {});

final stockscurrentPrices = StateProvider<Map<String, double>>((ref) => {});

final notificationServiceProvider = StateProvider<LocalNotificationService>(
    (ref) => LocalNotificationService());
