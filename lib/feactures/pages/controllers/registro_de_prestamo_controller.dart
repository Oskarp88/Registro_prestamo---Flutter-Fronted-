import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:registro_prestamos/common/screen/full_screen_loader.dart';
import 'package:registro_prestamos/feactures/pages/screens/clients/client_details.dart';
import 'package:registro_prestamos/model/client.dart';
import 'package:registro_prestamos/navigation_menu.dart';
import 'package:registro_prestamos/utils/connects/network_manager.dart';
import 'package:registro_prestamos/utils/constants/constants.dart';
import 'package:registro_prestamos/utils/loaders/loaders.dart';
import 'package:registro_prestamos/utils/manager/assets_manager.dart';

class RegistroDePrestamoController {
  Future<void>createPrestamo({
    required String id,
    required int totalLoan,
    required String dueDate,
  })async{
    
    OFullScreenLoader.openLoadingDialog('Registrando prestamo...', AssetsManager.clashcycle);
    final isConnected = await NetworkManager.instance.isConnected();

    if(!isConnected){
      OFullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'No hay conexión de internet');
      return;
    }
    final Uri url = Uri.parse('${dotenv.env[Constants.baseUrl]}/loan/create');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        Constants.clientId: id,
        Constants.totalLoan: totalLoan,
        Constants.dueDate: dueDate,
      })
    );
    
    if(response.statusCode == 200){
      OFullScreenLoader.stopLoading();
      Loaders.successSnackBar(
        title: 'Prestamo registrado exitosamente',
        message: 'Préstamo: $totalLoan, Fecha límite: $dueDate'
      );
      Get.offAll(()=> NavigationMenu());
    }else {
        final Map<String, dynamic> errorResponse = jsonDecode(response.body);
        final errorMessage = errorResponse['detail'] ?? 'Error desconocido';

        if (response.statusCode == 401) {
          Loaders.errorSnackBar(title: errorMessage);
          OFullScreenLoader.stopLoading();
          return;
        } else {
          OFullScreenLoader.stopLoading();
          throw 'Server error: ${response.statusCode} - $errorMessage';
        }
      } 
  }

  Future<void>payInterest({
    required String id,
    required double interest,
    required String name,
    required String lastname,
  })async{
     OFullScreenLoader.openLoadingDialog('Procesando Pago de interés...', AssetsManager.clashcycle);
    final isConnected = await NetworkManager.instance.isConnected();

    if(!isConnected){
      OFullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'No hay conexión de internet');
      return;
    }
    final Uri url = Uri.parse('${dotenv.env[Constants.baseUrl]}/loan/pay-interest');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        Constants.clientId: id,
        Constants.paidInterest: interest.toDouble(),
      })
    );
    
    if(response.statusCode == 200){
      final Map<String, dynamic> data = jsonDecode(response.body);
      OFullScreenLoader.stopLoading();
      Loaders.successSnackBar(
        title: 'Pago registrado exitosamente',
        message: 'Fecha límite para pagar: ${data['new_due_date']} el siguiente interes'
      );
      Get.to(()=> ClientDetails(clientId: id, lastname: lastname, name: name,));
    }else {
        final Map<String, dynamic> errorResponse = jsonDecode(response.body);
        final errorMessage = errorResponse['detail'] ?? 'Error desconocido';

        if (response.statusCode == 401) {
          Loaders.errorSnackBar(title: errorMessage);
          OFullScreenLoader.stopLoading();
          return;
        } else {
          OFullScreenLoader.stopLoading();
          throw 'Server error: ${response.statusCode} - $errorMessage';
        }
      } 
  }
  
}