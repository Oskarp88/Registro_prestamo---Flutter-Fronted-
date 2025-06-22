import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestapp/common/styles/my_text_style.dart';
import 'package:prestapp/common/widgets/appbar/appbar.dart';
import 'package:prestapp/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:prestapp/data/services/api_service.dart';
import 'package:prestapp/feactures/pages/screens/accounts/screen/details_accounts_client.dart';
import 'package:prestapp/model/loan.dart';
import 'package:prestapp/utils/constants/dimensions.dart';
import 'package:prestapp/utils/helpers/methods.dart';

class LoansAccountsScreen extends StatefulWidget {
  const LoansAccountsScreen({
    super.key,  
  });

  @override
  State<LoansAccountsScreen> createState() => _LoansAccountsScreenState();
}

class _LoansAccountsScreenState extends State<LoansAccountsScreen> {
  List<LoanModel> loanModel = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFechtLoans();
  }

  Future<void> _loadFechtLoans() async {
    try {
      final result = await ApiService().fetchLoans();
      setState(() {
        if(result.isNotEmpty){
          loanModel = result;
          _isLoading = false;
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error cargando interés: $e');
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    'Prestamos actuales por cliente',
                    style: MyTextStyle.headlineMedium,
                  ),
                ),
                const SizedBox(height: Dimensions.spaceBtwSections),
              ],
            ),
          ),
        ),

        /// Lista de intereses pendientes
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.defaultSpace),
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : (loanModel.isEmpty
                    ? const Center(
                        child: Text(
                          'No hay préstamos pendientes.',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: loanModel.length,
                        itemBuilder: (context, index) {
                          final loan = loanModel[index];
                          return GestureDetector(
                            onTap: () => Get.to(() => DetailsAccountsClient(loanModel: loan)),
                            child: Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                leading: const Icon(Icons.monetization_on),
                                title: Text(
                                  'Usuario ${loan.name[0].toUpperCase()}${loan.name.substring(1)} tiene un préstamo activo de \$${formatCurrency(loan.totalLoan)}.',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                              ),
                            ),
                          );
                        },
                      )),
          ),
        )
     ],
    ),
  );
}
}