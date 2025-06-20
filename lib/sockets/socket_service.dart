// lib/socket/socket_service.dart
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class SocketService {
  final String clientId;
  late WebSocketChannel _channel;

  Function(Map<String, dynamic>)? onNotification;

  SocketService(this.clientId) {
    _channel = WebSocketChannel.connect(
      Uri.parse('ws://localhost:8000/ws/notifications/$clientId'), // Ajusta si estás en producción
    );

    print("✅ Conectando WebSocket a: ws://localhost:8000/ws/notifications/$clientId");


    _channel.stream.listen((data) {
      final parsed = json.decode(data);
      if (parsed['type'] == 'notifications') {
        onNotification?.call(parsed);
      }
    });
  }

  void close() {
    _channel.sink.close();
  }
}
