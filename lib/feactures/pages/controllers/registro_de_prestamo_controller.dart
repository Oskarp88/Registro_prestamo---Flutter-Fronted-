import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:registro_prestamos/common/screen/full_screen_loader.dart';
import 'package:registro_prestamos/model/loan.dart';
import 'package:registro_prestamos/navigation_menu.dart';
import 'package:registro_prestamos/provider/client_provider.dart';
import 'package:registro_prestamos/utils/connects/network_manager.dart';
import 'package:registro_prestamos/utils/constants/constants.dart';
import 'package:registro_prestamos/utils/helpers/methods.dart';
import 'package:registro_prestamos/utils/loaders/loaders.dart';
import 'package:registro_prestamos/utils/manager/assets_manager.dart';

class RegistroDePrestamoController {
  Future<void>createPrestamo({
    required String id,
    required int totalLoan,
    required String dueDate,
    required String name,
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
        Constants.name: name,
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
  
  Future<void>updatePrestamo({
    required String id,
    required int totalLoan,
    required String dueDate,
  })async{
    
    print('***********************updatePrestamo ${Constants.clientId}: $id, ${Constants.totalLoan}: $totalLoan, ${Constants.dueDate}: $dueDate');
    OFullScreenLoader.openLoadingDialog('Registrando prestamo...', AssetsManager.clashcycle);
    final isConnected = await NetworkManager.instance.isConnected();

    if(!isConnected){
      OFullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'No hay conexión de internet');
      return;
    }
    final Uri url = Uri.parse('${dotenv.env[Constants.baseUrl]}/loan/update');

    final response = await http.put(
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
      final loanProvider = ClientProvider.instance;
      final Map<String, dynamic> data = jsonDecode(response.body);
      final updatedLoan = loanProvider.loanModel!.copyWith(
        dueDate: data['new_due_date'],
        status: data['status']
      );
      loanProvider.setLoan(updatedLoan);
      OFullScreenLoader.stopLoading();
      Loaders.successSnackBar(
        title: 'Pago registrado exitosamente',
        message: 'Fecha límite para pagar: ${data['new_due_date']} el siguiente interes'
      );
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
   
  Future<void>paymentAmount({
    required String id,
    required double paymentAmount,
  })async{
     OFullScreenLoader.openLoadingDialog('Procesando Pago...', AssetsManager.clashcycle);
    final isConnected = await NetworkManager.instance.isConnected();

    if(!isConnected){
      OFullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'No hay conexión de internet');
      return;
    }
    final Uri url = Uri.parse('${dotenv.env[Constants.baseUrl]}/loan/pay_amount');
    
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        Constants.clientId: id,
        Constants.paymentAmount: paymentAmount,
      })
    );
    
    if(response.statusCode == 200){
      final loanProvider = ClientProvider.instance;
      final Map<String, dynamic> data = jsonDecode(response.body);
      final updatedLoan = loanProvider.loanModel!.copyWith(
        totalLoan: data['total_loan'],
        interest: data['interest'],
        history: data['history'],
        status: data['status']
      );
      loanProvider.setLoan(updatedLoan);
      OFullScreenLoader.stopLoading();
      Loaders.successSnackBar(
        title: 'Pago registrado exitosamente',
        message: data['total_loan'] == 0
          ? 'Haz saldado toda tu deuda!'
          : 'Puedes seguir abonando a la deuda hasta esta fecha: ${data['due_date']} para disminuir el siguiente interes que el cual seria para el proximo pago esta cantidad: ${formatCurrency(data['interest'])}'
      );
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

   Future<void>paymentFull({
    required String id,
  })async{
     OFullScreenLoader.openLoadingDialog('Procesando Pago...', AssetsManager.clashcycle);
    final isConnected = await NetworkManager.instance.isConnected();

    if(!isConnected){
      OFullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'No hay conexión de internet');
      return;
    }
    final Uri url = Uri.parse('${dotenv.env[Constants.baseUrl]}/loan/pay_full');
    
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        Constants.clientId: id,
      })
    );
    
    if(response.statusCode == 200){
      final loanProvider = ClientProvider.instance;
      final Map<String, dynamic> data = jsonDecode(response.body);
       final updatedLoan = loanProvider.loanModel!.copyWith(
        totalLoan: 0,
        interest: 0,
        status: data['status'],
        history: data['history']
      );
      loanProvider.setLoan(updatedLoan);
      OFullScreenLoader.stopLoading();
      Loaders.successSnackBar(
        title: data['message'],
      );
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