import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestapp/common/styles/my_text_style.dart';
import 'package:prestapp/common/widgets/appbar/appbar.dart';
import 'package:prestapp/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:prestapp/feactures/pages/screens/accounts/screen/details_accounts_client.dart';
import 'package:prestapp/model/loan.dart';
import 'package:prestapp/utils/constants/dimensions.dart';
import 'package:prestapp/utils/helpers/methods.dart';

class InteresAccountsScreen extends StatelessWidget {
  const InteresAccountsScreen({super.key, required this.loanModel});
  final List<LoanModel> loanModel;
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
                    'Intereses pendientes',
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
            child: loanModel.isEmpty
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
                        onTap: ()=>Get.to(()=>DetailsAccountsClient(loanModel: loan)),
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.monetization_on),
                            title: Text(
                              'Usuario ${loan.name[0].toUpperCase()}${loan.name.substring(1)} debe \$${formatCurrency(loan.interest)} de interés.',
                              style: const TextStyle(fontSize: 16),
                            ),
                            subtitle: Text(
                              'Plazo de pago hasta el ${loan.dueDate}',
                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    ),
  );
}

}