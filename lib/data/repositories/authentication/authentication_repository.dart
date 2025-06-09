import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:registro_prestamos/common/screen/full_screen_loader.dart';
import 'package:registro_prestamos/feactures/authentication/screens/login/login.dart';
import 'package:registro_prestamos/navigation_menu.dart';
import 'package:registro_prestamos/utils/constants/constants.dart';
import 'package:registro_prestamos/utils/local_storage/storage_utility.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  @override
  void onReady() {
    screenRedirect();   
  }

   Future<void> screenRedirect() async {
    final userCredentials = UtilLocalStorage().readData(Constants.userCredentials);
    print('usercrendentiales********************: $userCredentials');
    final isLogin = UtilLocalStorage().readData(Constants.isLogin);
    print('isLogin______________________________: $isLogin');
    // Si no hay sesión activa en Google, redirigir a LoginScreen
    if (userCredentials == null) {
      if (kDebugMode) {
        print("No hay sesión activa de Google. Redirigiendo a LoginScreen.");
      }
      Get.offAll(() => const LoginScreen());
    } else {
        print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx $userCredentials');
        // Redirigir al BottomHomeNavigationBar
        if (kDebugMode) {
          print("Sesión activa detectada. Redirigiendo a BottomHomeNavigationBar.");
        }
      
        if(isLogin){
          OFullScreenLoader.stopLoading();
          UtilLocalStorage().removeData('isLogin');
        }
        Get.offAll(() => const NavigationMenu());
    }
  }
 
}