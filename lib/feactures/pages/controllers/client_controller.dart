import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:registro_prestamos/common/screen/full_screen_loader.dart';
import 'package:registro_prestamos/feactures/pages/screens/clients/registrar_prestamo.dart';
import 'package:registro_prestamos/model/client.dart';
import 'package:registro_prestamos/provider/client_provider.dart';
import 'package:registro_prestamos/utils/connects/network_manager.dart';
import 'package:registro_prestamos/utils/constants/constants.dart';
import 'package:registro_prestamos/utils/loaders/loaders.dart';
import 'package:registro_prestamos/utils/local_storage/storage_utility.dart';
import 'package:registro_prestamos/utils/manager/assets_manager.dart';
import 'package:http/http.dart' as http;

class ClientController {
  final clientProvider = ClientProvider.istance;
  Future<void> createClient({
    required String name,
    required String lastname,
    required int cedula,
    required String email,
    required String phoneNumber
  })async{
    OFullScreenLoader.openLoadingDialog('Creando nuevo cliente...', AssetsManager.clashcycle);
    final isConnected = await NetworkManager.instance.isConnected();

    if(!isConnected){
      OFullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'No hay conexión de internet');
      return;
    }

    final Uri url = Uri.parse('${dotenv.env[Constants.baseUrl]}/user/client/register');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        Constants.name: name,
        Constants.lastname: lastname,
        Constants.email: email,
        Constants.phoneNumber: phoneNumber,
        Constants.cedula: cedula,
      })
    );
    
    if(response.statusCode == 200){
      final Map<String, dynamic> clientData = jsonDecode(response.body);
      ClientModel clientModel = ClientModel.fromJson(clientData[Constants.user]);
      clientProvider.setClient(clientModel);
      print("llegue hasta registrar el cliente $clientData");
      await UtilLocalStorage().saveData(Constants.clientModel, clientData[Constants.user]);
      OFullScreenLoader.stopLoading();
      Loaders.successSnackBar(title: 'Registro exitoso', message: clientData[Constants.message]);
      Get.offAll(()=> RegistrarPrestamo());
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