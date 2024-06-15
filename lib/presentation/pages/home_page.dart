import 'package:finnhub_project/core/routes/routes.dart';
import 'package:finnhub_project/presentation/providers/presentation_providers.dart';
import 'package:finnhub_project/presentation/widgets/toast.dart';
import 'package:finnhub_project/utils/styles.dart';
import 'package:finnhub_project/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/constants.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String? _selectedValue = 'Choose a Stock';

  final TextEditingController _percentController = TextEditingController();
  @override
  void initState() {
    _selectedValue = ref.read(trendingStocksProvider).first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var trendingStock = ref.read(trendingStocksProvider);
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
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 25.0,
                    ),
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        Constants.welcomeTxt,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Center(
                      child: Text(
                        Constants.descriptionTxt,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Center(
                      child: Text(
                        Constants.addAlertTxt,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    child: Center(
                      child: Text(
                        Constants.chooseStockTxt,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _percentController,
                      keyboardType: TextInputType.number,
                      style: Styles.textStyleDropdownButton,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        labelText: Constants.enterPriceAlertTxt,
                        suffixIcon: Icon(
                          Icons.percent,
                          color: Colors.white70,
                        ),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  Center(
                    child: DropdownButton<String>(
                      value: _selectedValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                      items: trendingStock
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            Utils.fixStockName(value)!,
                            style: Styles.textStyleDropdownButton,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_percentController.text.isEmpty) {
                Toast.showToast(
                    context: context, message: Constants.emptyPricerAlertTxt);
              } else {
                ref.read(stockSelectedToBeNotified.notifier).update((state) =>
                    {_selectedValue!: double.parse(_percentController.text)});
                Navigator.of(context).pushNamed(
                  Routes.listStock,
                );
              }
            },
            child: const Icon(Icons.check),
          ),
        ),
      ),
    );
  }
}
