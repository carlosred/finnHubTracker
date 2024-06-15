import 'package:finnhub_project/domain/Models/stock_stream_item/stock_stream_item.dart';
import 'package:finnhub_project/presentation/providers/presentation_providers.dart';
import 'package:finnhub_project/utils/styles.dart';
import 'package:finnhub_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/Models/datum/datum.dart';

class TopHeaderListItemWidget extends ConsumerStatefulWidget {
  const TopHeaderListItemWidget({
    super.key,
    required this.stockStreamItem,
    required this.stock,
  });

  final StockStreamItem? stockStreamItem;
  final String stock;

  @override
  ConsumerState<TopHeaderListItemWidget> createState() =>
      _TopHeaderListItemWidgetState();
}

class _TopHeaderListItemWidgetState
    extends ConsumerState<TopHeaderListItemWidget> {
  String? stockName;
  String? priceText;
  double? change;
  double? percentChange;

  double _calculateChange(double value1, double value2) {
    return (value1 - value2).abs();
  }

  double _calculatePercentageChange(double oldValue, double newValue) {
    if (oldValue == 0) {
      throw ArgumentError('Old value cannot be zero');
    }
    return ((newValue - oldValue) / oldValue) * 100;
  }

  double? _getPrice(List<Datum> data) {
    double? result;
    if (data.isNotEmpty) {
      result =
          data.where((element) => element.s == widget.stock).toList().last.p;
    }

    return result;
  }

  @override
  void initState() {
    stockName = Utils.fixStockName(widget.stock);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant TopHeaderListItemWidget oldWidget) {
    if (widget.stockStreamItem!.type! == 'trade') {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _updatePrices(oldWidget);
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  void _updatePrices(covariant TopHeaderListItemWidget oldWidget) {
    var listTrades = widget.stockStreamItem?.data!
        .where((element) => element.s == widget.stock)
        .toList();

    String? stockFromStream;
    if ((listTrades!.isNotEmpty)) {
      stockFromStream = listTrades.last.s;
    } else {
      stockFromStream = null;
    }

    if (stockFromStream != null && mounted) {
      var mapPrevious;
      var oldListTrades;
      if (oldWidget.stockStreamItem!.type! != 'ping') {
        mapPrevious = ref.read(stocksPreviousPrices);

        oldListTrades = oldWidget.stockStreamItem?.data!
            .where((element) => element.s == widget.stock)
            .toList();
        var oldPrice = _getPrice(oldListTrades!);
        if (oldPrice != null) mapPrevious[stockFromStream] = oldPrice;
        ref.read(stocksPreviousPrices.notifier).state = mapPrevious;
        priceText = _getPrice(listTrades).toString();

        var currentPricesMap = mapPrevious = ref.read(stockscurrentPrices);

        currentPricesMap[stockFromStream] = double.parse(priceText!);
        ref
            .read(stockscurrentPrices.notifier)
            .update((state) => currentPricesMap);
      }

      setState(() {
        priceText = _getPrice(listTrades).toString();

        if (oldListTrades != null && oldListTrades.isNotEmpty) {
          change = _calculateChange(
              _getPrice(listTrades)!, _getPrice(oldListTrades)!);

          percentChange = _calculatePercentageChange(
              _getPrice(listTrades)!, _getPrice(oldListTrades)!);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              stockName ?? 'N/A',
              style: Styles.textstyleBarChartBottom,
            ),
            Text(
              priceText ?? '0.0',
              style: Styles.textstyleBarChartBottom,
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              (percentChange?.isNegative == true)
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_up,
              color: (percentChange?.isNegative == true)
                  ? Colors.red
                  : Colors.green,
            ),
            const SizedBox(width: 10.0),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 20,
                  color: (percentChange?.isNegative == true)
                      ? Colors.red
                      : Colors.green,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: '${percentChange?.toStringAsFixed(3) ?? 0.0}%'),
                  TextSpan(
                    text: '(${change?.toStringAsFixed(5) ?? '0.0'})',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: (percentChange?.isNegative == true)
                            ? Colors.red
                            : Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
