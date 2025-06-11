import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:registro_prestamos/common/screen/full_screen_loader.dart';
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
    
    print('id ************ $id');
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
}