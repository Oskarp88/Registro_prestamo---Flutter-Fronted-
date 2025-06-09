import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:registro_prestamos/data/repositories/authentication/authentication_repository.dart';
import 'package:registro_prestamos/data/repositories/user/user_repository.dart';
import 'package:registro_prestamos/feactures/authentication/controllers/auth_controller.dart';
import 'package:registro_prestamos/utils/connects/network_manager.dart';
import 'app.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NetworkManager());
  await dotenv.load();
  Get.lazyPut(() => AuthControllers());
  Get.lazyPut(() => UserRepository());
  Get.put(AuthenticationRepository());
   await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Permite solo modo vertical
  ]);
  runApp(const App());
}

