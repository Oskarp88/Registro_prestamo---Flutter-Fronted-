import 'dart:convert';
import 'dart:ui';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:prestapp/common/screen/full_screen_loader.dart';
import 'package:prestapp/data/repositories/authentication/authentication_repository.dart';
import 'package:prestapp/model/user.dart';
import 'package:prestapp/provider/auth_provider.dart';
import 'package:prestapp/utils/connects/network_manager.dart';
import 'package:prestapp/utils/constants/constants.dart';
import 'package:prestapp/utils/loaders/loaders.dart';
import 'package:prestapp/utils/local_storage/storage_utility.dart';
import 'package:prestapp/utils/manager/assets_manager.dart';

class AuthControllers {
  
  Future<void> singIn(String usernameOrEmail, String password) async{
    OFullScreenLoader.openLoadingDialog('Loggin you in...', AssetsManager.clashcycleDark);
    final isConnected = await NetworkManager.instance.isConnected();

    if (!isConnected) {
      OFullScreenLoader.stopLoading(); 
      Loaders.errorSnackBar(
        title: 'Sin conexión a Internet',
        message: 'Por favor revisa tu conexión e inténtalo de nuevo.'
      );
      return;
    }


      try {
        final Uri url = Uri.parse('${dotenv.env[Constants.baseUrl]}/auth/login');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body:  jsonEncode({ 
          Constants.usernameOrEmail: usernameOrEmail, 
          Constants.password: password 
        })
      );
      if (response.statusCode == 200) {
        final setAuth = AuthenticateProvider.instance;
        final Map<String, dynamic> userData = jsonDecode(response.body);
        UserModel userModel = UserModel.fromJson(userData[Constants.user]);
        setAuth.setUser(userModel);
        await UtilLocalStorage().saveData(Constants.userCredentials, userData[Constants.user]);
        await UtilLocalStorage().saveData(Constants.isLogin, true);
        await UtilLocalStorage().saveData(Constants.authToken, userData['access_token']);
        final bool isAdmin = userData[Constants.user]['isAdmin'] ?? false;

        final DateTime tokenExpiry = isAdmin
            ? DateTime.now().add(const Duration(minutes: 15)) // Admin → 15 minutos
            : DateTime.now().add(const Duration(days: 7));     // Usuario → 7 días

        await UtilLocalStorage().saveData(Constants.tokenExpiry, tokenExpiry.toIso8601String());
        await UtilLocalStorage().saveData('last_seen', DateTime.now().toIso8601String());

        AuthenticationRepository.instance.screenRedirect();    
        return;
      } else {
        final Map<String, dynamic> errorResponse = jsonDecode(response.body);
        final String errorMessage = errorResponse['detail'] ?? 'Error desconocido';

        if (response.statusCode == 401) {
          Loaders.errorSnackBar(title: errorMessage);
          OFullScreenLoader.stopLoading();
          return;
        }else if(response.statusCode == 403){
          Loaders.warningSnackBar(
            title: 'Asunto: ',
            message: errorMessage
          );
          OFullScreenLoader.stopLoading();
          return;
        } else {
          OFullScreenLoader.stopLoading();
          throw 'Server error: ${response.statusCode} - $errorMessage';
        }
      } 
      } catch (e) {
        OFullScreenLoader.stopLoading(); 
         Loaders.errorSnackBar(
          title: 'Error de red',
          message: 'No se pudo conectar con el servidor. Verifica tu conexión.',
        );
      }
    }
    
   Future<void> forgotPassword({
    required String usernameOrEmail,
    required Function(String usernameOrEmail) onSuccess,
  }) async {
    OFullScreenLoader.openLoadingDialog('Validando información...', AssetsManager.clashcycleDark);
    final isConnected = await NetworkManager.instance.isConnected();

    if (!isConnected) {
      OFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Sin conexión a internet');
      return;
    }

    final Uri url = Uri.parse('${dotenv.env[Constants.baseUrl]}/auth/forgot-password');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({Constants.emailOrUsername: usernameOrEmail}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        OFullScreenLoader.stopLoading();
        Loaders.successSnackBar(title: json['message']);
        onSuccess(usernameOrEmail);
      } else {
        final Map<String, dynamic> json = jsonDecode(response.body);
        OFullScreenLoader.stopLoading();
        Loaders.errorSnackBar(title: json['detail'] ?? 'Error desconocido');
      }
    } catch (e) {
      OFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Error de red', message: e.toString());
    }
  }

  Future<void> verifyResetCode({
    required String emailOrUsername,
    required String code,
    required Function(String userId) onSuccess,
  }) async {
    OFullScreenLoader.openLoadingDialog('Verificando código...', AssetsManager.clashcycleDark);
    final isConnected = await NetworkManager.instance.isConnected();

    if (!isConnected) {
      OFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Sin conexión a internet');
      return;
    }

    final Uri url = Uri.parse('${dotenv.env[Constants.baseUrl]}/auth/verify-reset-code');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          Constants.emailOrUsername: emailOrUsername,
          'code': code,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);     
        OFullScreenLoader.stopLoading(); 
        // Loaders.successSnackBar(title: json['message']);       
        onSuccess(json['user_id']); // Pasamos el userId a la siguiente pantalla
      } else {
        final Map<String, dynamic> json = jsonDecode(response.body);
        OFullScreenLoader.stopLoading();
        Loaders.errorSnackBar(title: json['detail'] ?? 'Error al verificar el código');
      }
    } catch (e) {
      OFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Error de red', message: e.toString());
    }
  }
    
  Future<void> resetPassword({
  required String userId,
  required String newPassword,
  required VoidCallback onSuccess,
  }) async {
    OFullScreenLoader.openLoadingDialog('Restableciendo contraseña...', AssetsManager.clashcycleDark);
    final isConnected = await NetworkManager.instance.isConnected();

    if (!isConnected) {
      OFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Sin conexión a internet');
      return;
    }

    final Uri url = Uri.parse('${dotenv.env[Constants.baseUrl]}/auth/reset-password');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'new_password': newPassword,
        }),
      );

      final json = jsonDecode(response.body);
      OFullScreenLoader.stopLoading();

      if (response.statusCode == 200) {
        Loaders.successSnackBar(title: json['message']);
        onSuccess(); // Redirige o realiza alguna acción adicional
      } else {
        Loaders.errorSnackBar(title: json['detail'] ?? 'Error al cambiar la contraseña');
      }
    } catch (e) {
      OFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Error de red', message: e.toString());
    }
  }


}