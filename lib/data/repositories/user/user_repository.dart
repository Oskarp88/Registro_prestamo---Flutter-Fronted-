import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:registro_prestamos/common/screen/full_screen_loader.dart';
import 'package:registro_prestamos/data/repositories/authentication/authentication_repository.dart';
import 'package:registro_prestamos/model/user.dart';
import 'package:registro_prestamos/provider/auth_provider.dart';
import 'package:registro_prestamos/utils/constants/constants.dart';
import 'package:registro_prestamos/utils/local_storage/storage_utility.dart';

class UserRepository extends GetxController {
 
  static UserRepository get instance => Get.find();

Future<void> saveUserRecord(Map<String, dynamic> user) async {
  try {
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
      final setAuth = AuthenticateProvider.instance;
      final Map<String, dynamic> userData = jsonDecode(response.body);
      setAuth.setUser(UserModel.fromJson(userData));
      UtilLocalStorage().saveData(Constants.userCredentials, userData[Constants.user]);
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
    print('Respuesta completa: ${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = jsonDecode(response.body);
      print('uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuus$userData');
      return UserModel.fromJson(userData); 
    } else {
      throw 'Error: ${response.statusCode} - ${response.body}';
    }
  } catch (e) {
    throw 'Something went wrong. Please try again. Error: $e';
  }
}

Future<bool?> isUserAlreadyExist(String? id) async {
  if (id == null || id.isEmpty) {
    throw 'ID cannot be null or empty';
  }

  final Uri url = Uri.parse('${dotenv.env['BASE_URL']}/userExist/$id');

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print('Respuesta del servidor: ${response.body}');

    if (response.statusCode == 200) {
      return true; // Usuario existe
    } else if (response.statusCode == 404) {
      return null; // Usuario no encontrado
    } else {
      throw 'Server error: ${response.statusCode} - ${response.body}';
    }
  } catch (e) {
    throw 'Something went wrong: $e';
  }
}
}