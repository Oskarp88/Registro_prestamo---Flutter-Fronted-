import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prestapp/common/screen/full_screen_loader.dart';
import 'package:prestapp/feactures/pages/screens/clients/registrar_prestamo.dart';
import 'package:prestapp/model/client.dart';
import 'package:prestapp/provider/client_provider.dart';
import 'package:prestapp/utils/connects/network_manager.dart';
import 'package:prestapp/utils/constants/constants.dart';
import 'package:prestapp/utils/loaders/loaders.dart';
import 'package:prestapp/utils/local_storage/storage_utility.dart';
import 'package:prestapp/utils/manager/assets_manager.dart';

class ClientController {
  final clientProvider = ClientProvider.instance;
  Future<void> createClient({
    required String name,
    required String lastname,
    required int cedula,
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
        Constants.phoneNumber: phoneNumber,
        Constants.cedula: cedula,
      })
    );
    
    if(response.statusCode == 200){
      final Map<String, dynamic> clientData = jsonDecode(response.body);
      ClientModel clientModel = ClientModel.fromJson(clientData[Constants.user]);
      clientProvider.setClient(clientModel);
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