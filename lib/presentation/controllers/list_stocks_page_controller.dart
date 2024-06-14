import 'package:finnhub_project/presentation/providers/presentation_providers.dart';
import 'package:finnhub_project/services/local_notifications_service.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../domain/Models/stock_stream_item/stock_stream_item.dart';
import '../pages/helper_methods.dart';

part 'list_stocks_page_controller.g.dart';

@Riverpod(keepAlive: true)
class ListStockPageController extends _$ListStockPageController {
  @override
  Future<Stream<dynamic>?> build() async {
    return null;
  }

  Future<void> getStreamStocks() async {
    state = const AsyncLoading();
    try {
      final wsUrl = Uri.parse(
          'wss://ws.finnhub.io?token=cpjlpd1r01qs8l01hphgcpjlpd1r01qs8l01hpi0');
      final channel = WebSocketChannel.connect(wsUrl);

      await channel.ready;

      var trendingStocks = ref.read(trendingStocksProvider);

      for (var value in trendingStocks) {
        var msg = '{"type":"subscribe","symbol":"$value"}';
        channel.sink.add(msg);
      }

      state = AsyncData(channel.stream.asBroadcastStream());
    } catch (error, stack) {
      state = AsyncError(error, stack);
    }
  }

  void checkForSelectedStock() {
    var prices = ref.read(stockscurrentPrices);
    if (prices.isNotEmpty) {
      var stockSelected = ref.read(stockSelectedToBeNotified);
      var stockSelectedName = stockSelected.keys.toList().first;
      var stockSelectedValue = stockSelected.values.toList().first;
      var currentPriceStockSelected = prices[stockSelectedName];
      if (currentPriceStockSelected != null &&
          currentPriceStockSelected >= stockSelectedValue) {
        LocalNotificationService().showNotifcation(
            title: 'Price Alert!!',
            body:
                'The stock $stockSelectedName has reached the value of $stockSelectedValue or more!');
      }
    }
  }
}
