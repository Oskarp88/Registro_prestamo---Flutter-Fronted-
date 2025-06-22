import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:prestapp/common/screen/full_screen_loader.dart';
import 'package:prestapp/data/services/api_service.dart';
import 'package:prestapp/feactures/authentication/screens/login/login.dart';
import 'package:prestapp/model/user.dart';
import 'package:prestapp/navigation_menu.dart';
import 'package:prestapp/provider/auth_provider.dart';
import 'package:prestapp/provider/notification_provider.dart';
import 'package:prestapp/utils/constants/constants.dart';
import 'package:prestapp/utils/local_storage/storage_utility.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();
  final user = AuthenticateProvider.instance;

  @override
  void onReady() {
    screenRedirect();   
  }

   Future<void> screenRedirect() async {
    final expiry = UtilLocalStorage().readData(Constants.tokenExpiry);
    final lastSeenStr = UtilLocalStorage().readData('last_seen');
    final userCredentials = UtilLocalStorage().readData(Constants.userCredentials);
    final isLogin = UtilLocalStorage().readData(Constants.isLogin) ?? false;

    // Cerrar sesión si token expiró
    if (expiry == null || DateTime.now().isAfter(DateTime.parse(expiry))) {
      await signOut();
      return;
    }

    // Cerrar sesión si pasó 1 semana sin entrar (solo para usuarios normales)
    if (lastSeenStr != null && userCredentials != null) {
      final isAdmin = userCredentials['isAdmin'] ?? false;

      if (!isAdmin) {
        final lastSeen = DateTime.parse(lastSeenStr);
        if (DateTime.now().difference(lastSeen).inDays >= 7) {
          await signOut();
          return;
        } else {
          // actualizar última visita
          await UtilLocalStorage().saveData('last_seen', DateTime.now().toIso8601String());
        }
      }
    }


    if (userCredentials == null) {
      if (kDebugMode) {
        print("No hay sesión activa de Google. Redirigiendo a LoginScreen.");
      }
      Get.offAll(() => const LoginScreen());
    } else {
        user.setUser(UserModel.fromJson(userCredentials));
        user.notificationsProvider = ProviderNotifications(user.user!.id); 

        // Redirigir al BottomHomeNavigationBar
        if (kDebugMode) {
          print("Sesión activa de ${user.user!.username} detectada. Redirigiendo a BottomHomeNavigationBar.");
        }
         try {
          await ApiService().fetchCapital();
        } catch (e) {
          if (kDebugMode) {
            print('Error cargando capital: $e');
          }
        }
      
        if(isLogin){
          OFullScreenLoader.stopLoading();
          UtilLocalStorage().removeData('isLogin');
        }
        Get.offAll(() => const NavigationMenu());
    }
  }
    
  Future<void> signOut() async {
    try {    
      user.clearUser();
      await  UtilLocalStorage().removeData(Constants.userCredentials);
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      if (kDebugMode) {
        print('Error al cerrar sesión: $e');
      }
    }
  }
 
}