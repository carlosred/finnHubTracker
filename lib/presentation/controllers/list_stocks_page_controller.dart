import 'package:finnhub_project/data/providers/data_providers.dart';
import 'package:finnhub_project/presentation/providers/presentation_providers.dart';
import 'package:finnhub_project/services/local_notifications_service.dart';
import 'package:finnhub_project/services/web_socket_service.dart';
import 'package:finnhub_project/utils/constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
      final trendingStocks = ref.read(trendingStocksProvider);

      final websocketService = ref.read(websocketsProvider.notifier).update(
            (state) => WebSocketService(
                Constants.websocketUrl, trendingStocks, (p0) => null),
          );

      await websocketService?.subscribeToTopic();

      state = AsyncData(websocketService?.channel.stream.asBroadcastStream());
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
