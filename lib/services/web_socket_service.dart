import 'package:finnhub_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  late WebSocketChannel channel;
  Function(String) onMessage;
  List<String> stocks;

  WebSocketService(String url, this.stocks, this.onMessage) {
    channel = WebSocketChannel.connect(Uri.parse(Constants.websocketUrl));
  }

  Future<void> subscribeToTopic() async {
    await channel.ready;

    for (var value in stocks) {
      var msg = '{"type":"subscribe","symbol":"$value"}';
      channel.sink.add(msg);
      debugPrint('suscribe it to $value');
    }
  }

  void sendMessage(String message) {
    channel.sink.add(message);
  }

  void dispose() {
    channel.sink.close();
  }
}
