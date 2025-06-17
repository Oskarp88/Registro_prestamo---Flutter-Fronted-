import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:registro_prestamos/common/screen/full_screen_loader.dart';
import 'package:registro_prestamos/model/capital.dart';
import 'package:registro_prestamos/provider/auth_provider.dart';
import 'package:registro_prestamos/utils/connects/network_manager.dart';
import 'package:registro_prestamos/utils/constants/constants.dart';
import 'package:registro_prestamos/utils/helpers/methods.dart';
import 'package:registro_prestamos/utils/loaders/loaders.dart';
import 'package:registro_prestamos/utils/manager/assets_manager.dart';

class CapitalController {
  Future<void>addCapital({
    required double capital,
  })async{
    
    OFullScreenLoader.openLoadingDialog('Registrando ...', AssetsManager.clashcycle);
    final isConnected = await NetworkManager.instance.isConnected();

    if(!isConnected){
      OFullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'No hay conexión de internet');
      return;
    }
    final Uri url = Uri.parse('${dotenv.env[Constants.baseUrl]}/account/add-capital');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        Constants.amount: capital,
      })
    );
    
    if(response.statusCode == 200){
      final capitalProvider = AuthenticateProvider.instance;
      final Map<String, dynamic> capitalResponse = jsonDecode(response.body);
      final capital = capitalProvider.capital!.copyWith(
        capital: capitalResponse[Constants.capital]
      );
      capitalProvider.setCapital(capital);
      OFullScreenLoader.stopLoading();
      Loaders.successSnackBar(
        title: capitalResponse[Constants.message],
        message: 'Nuevo Capital: ${formatCurrency(capitalResponse[Constants.capital])}',
        time: 3,
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

  Future<void>withdrawGanancias({
    required amount
  }) async{
    OFullScreenLoader.openLoadingDialog('Retirando...', AssetsManager.clashcycle);
    final isConnected = await NetworkManager.instance.isConnected();

    if(!isConnected){
      OFullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'No hay conexión de internet');
      return;
    }
    final Uri url = Uri.parse('${dotenv.env[Constants.baseUrl]}/account/withdraw-ganancias');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        Constants.amount: amount,
      })
    );
    
    if(response.statusCode == 200){
      final capitalProvider = AuthenticateProvider.instance;
      final Map<String, dynamic> capitalResponse = jsonDecode(response.body);
      final capital = capitalProvider.capital!.copyWith(
        ganancias: capitalResponse[Constants.ganancias]
      );
      capitalProvider.setCapital(capital);
      OFullScreenLoader.stopLoading();
      Loaders.successSnackBar(
        title: capitalResponse[Constants.message],
        message: 'Has retirado: ${formatCurrency(amount)}',
        time: 3,
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

  Future<void>transferCapitalToGanancias({
    required double amount,
  })async{
    
    OFullScreenLoader.openLoadingDialog('Transfiriendo ...', AssetsManager.clashcycle);
    final isConnected = await NetworkManager.instance.isConnected();

    if(!isConnected){
      OFullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'No hay conexión de internet');
      return;
    }
    final Uri url = Uri.parse('${dotenv.env[Constants.baseUrl]}/account/transfer-capital-to-ganancias');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        Constants.amount: amount,
      })
    );
    
    if(response.statusCode == 200){
      final capitalProvider = AuthenticateProvider.instance;
      final Map<String, dynamic> capitalResponse = jsonDecode(response.body);
      final capital = capitalProvider.capital!.copyWith(
        capital: capitalResponse[Constants.capital],
        ganancias: capitalResponse[Constants.ganancias]
      );
      capitalProvider.setCapital(capital);
      OFullScreenLoader.stopLoading();
      Loaders.successSnackBar(
        title: capitalResponse[Constants.message],
        message: 'Nuevo Capital: ${formatCurrency(capitalResponse[Constants.capital])} \n'
                 'Ganancias: ${formatCurrency(capitalResponse[Constants.ganancias])}',
        time: 3,
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

   Future<void>transferGananciasToCapital({
    required double amount,
  })async{
    
    OFullScreenLoader.openLoadingDialog('Transfiriendo ...', AssetsManager.clashcycle);
    final isConnected = await NetworkManager.instance.isConnected();

    if(!isConnected){
      OFullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'No hay conexión de internet');
      return;
    }
    final Uri url = Uri.parse('${dotenv.env[Constants.baseUrl]}/account/transfer-ganancias-to-capital');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        Constants.amount: amount,
      })
    );
    
    if(response.statusCode == 200){
      final capitalProvider = AuthenticateProvider.instance;
      final Map<String, dynamic> capitalResponse = jsonDecode(response.body);
      final capital = capitalProvider.capital!.copyWith(
        capital: capitalResponse[Constants.capital],
        ganancias: capitalResponse[Constants.ganancias]
      );
      capitalProvider.setCapital(capital);
      OFullScreenLoader.stopLoading();
      Loaders.successSnackBar(
        title: capitalResponse[Constants.message],
        message: 'Nuevo Capital: ${formatCurrency(capitalResponse[Constants.capital])} \n'
                 'Ganancias: ${formatCurrency(capitalResponse[Constants.ganancias])}',
        time: 3,
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
 