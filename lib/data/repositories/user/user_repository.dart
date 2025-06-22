import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prestapp/common/screen/full_screen_loader.dart';
import 'package:prestapp/data/repositories/authentication/authentication_repository.dart';
import 'package:prestapp/model/user.dart';
import 'package:prestapp/utils/connects/network_manager.dart';
import 'package:prestapp/utils/loaders/loaders.dart';
import 'package:prestapp/utils/manager/assets_manager.dart';

class UserRepository extends GetxController {
 
  static UserRepository get instance => Get.find();

Future<void> userRegister(Map<String, dynamic> user) async {
  try {
    OFullScreenLoader.openLoadingDialog('Creando nuevo cliente...', AssetsManager.clashcycle);
    final isConnected = await NetworkManager.instance.isConnected();

    if(!isConnected){
      OFullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'No hay conexión de internet');
      return;
    }
    
    final Uri url = Uri.parse('${dotenv.env['BASE_URL']}/user/register');

    // Enviar solicitud POST con JSON
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user),
    );

     if (response.statusCode == 200) {
      OFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
      return;
    } 
    
  } catch (e) {
    throw 'Something went wrong. Please try again. Error: $e';
  }
}
  
  Future<UserModel> fetchUserDetails(String? id) async {
  try {
    final Uri url = Uri.parse('${dotenv.env['BASE_URL']}/user/$id');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = jsonDecode(response.body);
      return UserModel.fromJson(userData); 
    } else {
      throw 'Error: ${response.statusCode} - ${response.body}';
    }
  } catch (e) {
    throw 'Something went wrong. Please try again. Error: $e';
  }
}

}