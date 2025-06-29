import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prestapp/common/styles/my_text_style.dart';
import 'package:prestapp/common/widgets/appbar/appbar.dart';
import 'package:prestapp/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:prestapp/common/widgets/custom_shapes/container/search_container.dart';
import 'package:prestapp/data/services/api_service.dart';
import 'package:prestapp/feactures/pages/screens/clients/client_details.dart';
import 'package:prestapp/model/client.dart';
import 'package:prestapp/provider/client_provider.dart';
import 'package:prestapp/utils/constants/constants.dart';
import 'package:prestapp/utils/constants/dimensions.dart';
import 'package:prestapp/utils/helpers/methods.dart';
import 'package:provider/provider.dart';

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({super.key});

  @override
  State<ClientListScreen> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  late Future<List<ClientWithLoan>> _clientsWithLoan;
  final TextEditingController _searchController = TextEditingController();
  List<ClientWithLoan> _allClients = [];
  List<ClientWithLoan> _filteredClients = [];

  @override
  void initState() {
    super.initState();
    _clientsWithLoan = _loadClientsWithLoanStatus();
    _clientsWithLoan.then((value) {
      setState(() {
        _allClients = value;
        _filteredClients = value;
      });
    });
  }

  Future<List<ClientWithLoan>> _loadClientsWithLoanStatus() async {
    final clients = await ApiService().fetchClient();

    final futures = clients.map((client) async {
      final loan = await ApiService().getLoanByClientId(client.id);
      final status = loan?.status ?? 'Sin préstamo';
      final deuda = loan?.totalLoan ?? 0;
      return ClientWithLoan(client: client, loanStatus: status, totalLoan: deuda);
    });

    return Future.wait(futures);
  }

  void _filterClients(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredClients = _allClients;
      });
    } else {
      final lowerQuery = query.toLowerCase();
      setState(() {
        _filteredClients = _allClients.where((client) {
          final name = client.client.name.toLowerCase();
          final lastname = client.client.lastname.toLowerCase();
          final cedula = client.client.cedula.toString();
          final phone = client.client.phoneNumber;

          return name.contains(lowerQuery) ||
                 lastname.contains(lowerQuery) ||
                 cedula.contains(lowerQuery) ||
                 phone.contains(lowerQuery);
        }).toList();
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final setClient = context.read<ClientProvider>().setClient;
    return Scaffold(
      body: Column(
        children: [
          PrimaryHeaderContainer(
            child: Padding(
              padding: const EdgeInsets.only(top: Dimensions.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarWidget(
                    showBackArrow: true,
                    title: Text(
                      'Lista de Clientes',
                      style: MyTextStyle.headlineMedium,
                    ),
                  ),
                  SearchContainer(
                    hintText: 'Buscar cliente',
                    onChanged: _filterClients,
                  ),
                  const SizedBox(height: Dimensions.spaceBtwSections),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
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

                  //validación si no hay coincidencias
                  if (_filteredClients.isEmpty) {
                    return const Center(
                      child: Text(
                        'Cliente no encontrado',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: _filteredClients.length,
                    itemBuilder: (context, index) {
                      final item = _filteredClients[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: ListTile(
                          title: Text(
                            '${item.client.name[0].toUpperCase()}${item.client.name.substring(1)} ${item.client.lastname[0].toUpperCase()}${item.client.lastname.substring(1)}',
                            style: Theme.of(context).textTheme.titleLarge,
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
                                    item.totalLoan == 0
                                      ? "Finalizado"
                                      : formatCurrency(item.totalLoan),
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
                                  Row(
                                    children: [
                                      Icon(
                                        item.loanStatus == Constants.interesPagado
                                          ?  Iconsax.wallet_check
                                          : item.loanStatus == Constants.enMora
                                            ? Iconsax.warning_2
                                            : item.loanStatus == Constants.pendiente
                                              ? Iconsax.clock
                                              : Iconsax.verify, 
                                        color: item.loanStatus == Constants.interesPagado
                                          ?  Colors.lightBlue
                                          : item.loanStatus == Constants.enMora
                                            ? Colors.deepOrange
                                            : item.loanStatus == Constants.pendiente
                                              ? Colors.orangeAccent
                                              : Colors.green,
                                        size: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        item.loanStatus == Constants.interesPagado
                                          ? 'Interés pagado al dia'
                                          : item.loanStatus,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                                              color: item.loanStatus == Constants.pendiente
                                                  ? Colors.orangeAccent
                                                  : item.loanStatus == Constants.enMora
                                                      ? Colors.deepOrange
                                                      : item.loanStatus == Constants.interesPagado
                                                          ? Colors.lightBlue
                                                          : Colors.green,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          leading: const Icon(Icons.person),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            setClient(item.client);
                            Get.to(() => ClientDetails(
                                  clientId: item.client.id,
                                ));
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ClientWithLoan {
  final ClientModel client;
  final String loanStatus;
  final double totalLoan;

  ClientWithLoan({
    required this.client,
    required this.loanStatus,
    required this.totalLoan,
  });
}

