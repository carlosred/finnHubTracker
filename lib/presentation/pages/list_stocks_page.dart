import 'dart:async';

import 'package:finnhub_project/presentation/controllers/list_stocks_page_controller.dart';
import 'package:finnhub_project/presentation/providers/presentation_providers.dart';

import 'package:finnhub_project/utils/constants.dart';
import 'package:finnhub_project/utils/styles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/loader.dart';
import '../widgets/stocks_chart.dart';
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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: Container(
            height: height,
            width: width,
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
                                    Constants.trendingStockTxt,
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
                                    Constants.trendingStockBarCharTxt,
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
                    return const Loader();
                  }
                },
                error: (error, stackTrace) => Center(
                  child: Text('${Constants.somethingWentWrongTxt} : $error'),
                ),
                loading: () => const Loader(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
