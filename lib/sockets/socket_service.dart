// lib/socket/socket_service.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:registro_prestamos/utils/constants/constants.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class SocketService {
  final String clientId;
  late WebSocketChannel _channel;

  Function(Map<String, dynamic>)? onNotification;

  SocketService(this.clientId) {
    _channel = WebSocketChannel.connect(
      Uri.parse('${dotenv.env[Constants.socketUrl]}/notifications/$clientId'), // Ajusta si estás en producción
    );


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
