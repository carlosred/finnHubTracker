import 'dart:async';
import 'dart:convert';

import 'package:finnhub_project/presentation/controllers/list_stocks_page_controller.dart';
import 'package:finnhub_project/presentation/providers/presentation_providers.dart';
import 'package:finnhub_project/utils/styles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;
import '../../domain/Models/quote/quote.dart';
import '../../domain/Models/stock/stock.dart';
import '../../utils/constants.dart';
import '../widgets/stocks_chart.dart';
import '../widgets/top_header_List_item_widget.dart';
import '../widgets/top_header_list_widget.dart';

class ListStockPage extends ConsumerStatefulWidget {
  const ListStockPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<ListStockPage> {
  Timer? timerTrendingStock;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref
          .read(listStockPageControllerProvider.notifier)
          .getStreamStocks();

      ref.read(notificationServiceProvider).initNotification();
    });
    super.initState();
  }

  @override
  void dispose() {
    timerTrendingStock?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var listStockController = ref.watch(listStockPageControllerProvider);
    var trendingStock = ref.read(trendingStocksProvider);
    var pricesMap = ref.watch(stockscurrentPrices);

    return Scaffold(
      body: Container(
        decoration: Styles.backgroundGradient,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: listStockController.when(
            skipLoadingOnRefresh: true,
            skipLoadingOnReload: true,
            data: (data) {
              if (data != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          const Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Trending Stocks',
                                style: Styles.textStyleDropdownButton,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: ListView.separated(
                              addAutomaticKeepAlives: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => SizedBox(
                                width: 190,
                                child: TopHeaderListWidget(
                                  stream: data,
                                  stock: trendingStock[index],
                                ),
                              ),
                              itemCount: trendingStock.length,
                              separatorBuilder: (context, index) =>
                                  VerticalDivider(
                                color: Colors.white.withOpacity(0.5),
                                thickness: 1,
                                width: 20,
                                indent: 0,
                                endIndent: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Column(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Trending stocks chart',
                                style: Styles.textStyleDropdownButton,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: StockChart(
                              pricesMap: pricesMap,
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: SizedBox(),
                          )
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      Color(0xff51B046),
                    ),
                    strokeWidth: 3,
                  ),
                );
              }
            },
            error: (error, stackTrace) => Center(
              child: Text('Something went wrong =( $error'),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Color(0xff51B046),
                ),
                strokeWidth: 3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ListStockITemWidget extends StatelessWidget {
  const ListStockITemWidget({
    super.key,
    required this.stock,
  });

  final Stock stock;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 90,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.orange, // Background color of the circle
            child: Icon(
              Icons.currency_bitcoin,
              color: Colors.white,
            ),
          ),
          title: Text(stock.symbol!),
          subtitle: Text('${stock.description!} - Currency:${stock.currency!}'),
        ),
      ),
    );
  }
}
