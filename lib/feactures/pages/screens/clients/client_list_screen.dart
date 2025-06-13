import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registro_prestamos/common/widgets/appbar/appbar.dart';
import 'package:registro_prestamos/data/services/api_service.dart';
import 'package:registro_prestamos/feactures/pages/screens/clients/client_details.dart';
import 'package:registro_prestamos/model/client.dart';
import 'package:registro_prestamos/utils/constants/my_colors.dart';
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
      appBar: AppBarWidget(
        color: MyColors.primary,
        showBackArrow: true,
        title: Text(
          'Lista de Clientes', 
          style: Theme.of(context).textTheme.headlineMedium,
        )
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: FutureBuilder<List<ClientWithLoan>>(
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
                    title: Text(
                      '${item.client.name} ${item.client.lastname}',
                      style: Theme.of(context).textTheme.titleLarge
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Deuda total: ',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              formatCurrency(item.totalLoan),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Estado de pago de interés: ',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              item.loanStatus,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium!.apply(
                                color: item.loanStatus == 'pendiente' 
                                  ? Colors.orangeAccent
                                  : item.loanStatus == 'atrasado'
                                    ? Colors.deepOrange
                                    :  item.loanStatus == 'no pago'
                                      ? Colors.red
                                      : Colors.green
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    leading: const Icon(Icons.person),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Get.to(() => ClientDetails(
                        clientId: item.client.id,
                        name: item.client.name,
                        lastname: item.client.lastname,
                      ));
                    },
                  ),
                );
              },
            );
          },
        ),
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
