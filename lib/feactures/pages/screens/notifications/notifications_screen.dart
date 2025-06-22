import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prestapp/provider/auth_provider.dart';
import 'package:prestapp/provider/notification_provider.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final provider = Provider.of<ProviderNotifications>(context, listen: false);
      final user = Provider.of<AuthenticateProvider>(context, listen: false).user!;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        provider.markAllAsRead(user.id); // Marcar como leídas al entrar
      });

      _initialized = true;
    }
  }

  String formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;

    if (diff == 0) return 'Hoy';
    if (diff == 1) return 'Ayer';
    if (diff <= 3) return '$diff días atrás';
    return DateFormat("d 'de' MMMM y", 'es_ES').format(date);
  }

  String formatHour(DateTime date) {
    return DateFormat('HH:mm', 'es_ES').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final notifications = context.watch<ProviderNotifications>().notifications;

    // Agrupar por fecha amigable
    final Map<String, List<Map<String, dynamic>>> grouped = {};

    for (var notif in notifications) {
      final date = DateTime.parse(notif['creation_date']);
      final label = formatDate(date);

      grouped.putIfAbsent(label, () => []).add({
        'message': notif['message'],
        'time': formatHour(date),
      });
    }

    if (notifications.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text("No tienes notificaciones aún."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: grouped.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  entry.key,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ...entry.value.map(
                (item) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.notifications, color: Colors.blue),
                    title: Text(item['message']),
                    subtitle: Text(item['time']),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
