import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../domain/models/stock_stream_item/stock_stream_item.dart';
import 'loader.dart';
import 'top_header_List_item_widget.dart';

class TopHeaderListWidget extends StatefulWidget {
  const TopHeaderListWidget({
    super.key,
    required this.stream,
    required this.stock,
  });

  final Stream<dynamic> stream;
  final String stock;

  @override
  State<TopHeaderListWidget> createState() => _TopHeaderListWidgetState();
}

class _TopHeaderListWidgetState extends State<TopHeaderListWidget>
    with AutomaticKeepAliveClientMixin {
  String? priceText;
  String? stockName;
  late StreamController<dynamic> _streamController;
  @override
  void initState() {
    _streamController = StreamController<dynamic>.broadcast();
    if (!_streamController.isClosed) {
      _streamController.addStream(widget.stream);
    }

    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();

    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('No data received');
        } else {
          var messageJson = jsonDecode(snapshot.data);
          var stockStreamItem = StockStreamItem.fromJson(messageJson);
          debugPrint(stockStreamItem.toString());
          stockName = stockStreamItem.data?.first.s;

          return TopHeaderListItemWidget(
            stockStreamItem: stockStreamItem,
            stock: widget.stock,
          );
        }
      },
    );
  }
}
