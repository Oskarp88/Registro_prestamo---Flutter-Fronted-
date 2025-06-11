import 'package:flutter/material.dart';
import 'package:registro_prestamos/data/services/api_service.dart';
import 'package:registro_prestamos/model/client.dart';
import 'package:registro_prestamos/utils/helpers/methods.dart';

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({super.key});

  @override
  State<ClientListScreen> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  late Future<List<ClientWithLoan>> _clientsWithLoan;

  @override
  void initState() {
    super.initState();
    _clientsWithLoan = _loadClientsWithLoanStatus();
  }

  Future<List<ClientWithLoan>> _loadClientsWithLoanStatus() async {
    final clients = await ApiService().fetchClassicalRatings();

    final futures = clients.map((client) async {
      final loan = await ApiService().getLoanByClientId(client.id);
      final status = loan?.status ?? 'Sin préstamo';
      final deuda = loan?.totalLoan ?? 0;
      return ClientWithLoan(client: client, loanStatus: status, totalLoan: deuda);
    });

    return Future.wait(futures);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Clientes')),
      body: FutureBuilder<List<ClientWithLoan>>(
        future: _clientsWithLoan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay clientes registrados'));
          }

          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ListTile(
                  title: Text('${item.client.name} ${item.client.lastname}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Deuda total: ${formatCurrency(item.totalLoan)}'),
                      Text('Estado de pago de interés: ${item.loanStatus}'),
                    ],
                  ),
                  leading: const Icon(Icons.person),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ClientWithLoan {
  final ClientModel client;
  final String loanStatus;
  final double totalLoan;
  ClientWithLoan( {required this.client, required this.loanStatus, required this.totalLoan});
}
