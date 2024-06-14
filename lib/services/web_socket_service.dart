import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  late WebSocketChannel channel;
  Function(String) onMessage;
  String stock;

  WebSocketService(String url, this.stock, this.onMessage) {
    channel = WebSocketChannel.connect(Uri.parse(url));
  }

  void subscribeToTopic() {
    final subscriptionMessage = '{"type":"subscribe","symbol":"$stock"}';

    channel.sink.add(subscriptionMessage);

    debugPrint('suscribe it to $stock');
  }

  void sendMessage(String message) {
    channel.sink.add(message);
  }

  void dispose() {
    channel.sink.close();
  }
}
