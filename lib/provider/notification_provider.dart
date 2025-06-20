// lib/provider/provider_notifications.dart
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:registro_prestamos/sockets/socket_service.dart';
import 'package:registro_prestamos/utils/constants/constants.dart';

class ProviderNotifications extends ChangeNotifier {
  final SocketService _socketService;
  List<Map<String, dynamic>> _notifications = [];
  int _unreadCount = 0;

  List<Map<String, dynamic>> get notifications => _notifications;
  int get unreadCount => _unreadCount;

  ProviderNotifications(String userId)
      : _socketService = SocketService(userId) {
    _socketService.onNotification = _handleNotificationData;
    loadNotificationsFromBackend(userId);
  }

  void _handleNotificationData(Map<String, dynamic> data) {
    _notifications = List<Map<String, dynamic>>.from(data['notifications']);
    _unreadCount = data['unread_count'] ?? 0;
    notifyListeners();
  }

  Future<void> loadNotificationsFromBackend(String userId) async {
    final url = Uri.parse('${dotenv.env[Constants.baseUrl]}/user/notifications/$userId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _notifications = List<Map<String, dynamic>>.from(data['notifications']);
      _unreadCount = data['unread_count'];
      notifyListeners();
    } else {
      throw Exception('Error al cargar notificaciones');
    }
  }


  void markAllAsRead(String userId) async {
    _unreadCount = 0;
    notifyListeners();

    final url = '${dotenv.env[Constants.baseUrl]}/user/notifications/mark_read/$userId';

    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (kDebugMode) {
          print('✅ Notificaciones marcadas como leídas: ${data['modified_count']}');
        }
      } else {
        if (kDebugMode) {
          print('❌ Error al marcar como leídas: ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error de red: $e');
      }
    }
  }

  @override
  void dispose() {
    _socketService.close();
    super.dispose();
  }
}
