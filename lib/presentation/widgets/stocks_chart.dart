import 'dart:async';

import 'package:finnhub_project/presentation/controllers/list_stocks_page_controller.dart';
import 'package:finnhub_project/presentation/providers/presentation_providers.dart';
import 'package:finnhub_project/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/utils.dart';

class StockChart extends ConsumerStatefulWidget {
  const StockChart({
    required this.pricesMap,
    super.key,
  });

  final Map<String, double> pricesMap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _StockChartState();
  }
}

class _StockChartState extends ConsumerState<StockChart> {
  Timer? _timer;
  Map<String, double> _mapPrices = {};
  String? getTitleFromValue(Map<String, double> map, double value) {
    String? result;
    if (value != 0.0) {
      result = map.entries
          .firstWhere(
            (entry) => entry.value == value,
          )
          .key;
    }
    return result;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        var prices = ref.read(stockscurrentPrices);
        ref
            .read(listStockPageControllerProvider.notifier)
            .checkForSelectedStock();
        setState(() {
          _mapPrices = prices;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.toString(),
              const TextStyle(
                color: Styles.mainAppColor,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );
  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Colors.white,
          Styles.mainAppColor,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Styles.backgroundColor.withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Expanded(
              flex: 2,
              child: Row(
                children: [
                  Text('Stocks prices', style: Styles.textStyleDropdownButton),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              flex: 8,
              child: BarChart(
                swapAnimationCurve: Curves.easeInCirc,
                swapAnimationDuration: Durations.extralong1,
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 80000,
                  barTouchData: barTouchData,
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          String? title = Utils.fixStockName(
                              _mapPrices.keys.toList()[value.toInt()]);
                          return SideTitleWidget(
                            axisSide: AxisSide.bottom,
                            child: Text(
                              title!,
                              style: Styles.textstyleBarChartBottom,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: _mapPrices.entries.map((entry) {
                    int index = _mapPrices.keys.toList().indexOf(entry.key);
                    return BarChartGroupData(
                      showingTooltipIndicators: [0],
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value,
                          gradient: _barsGradient,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
