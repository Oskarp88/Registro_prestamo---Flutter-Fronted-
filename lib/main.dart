import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:registro_prestamos/data/repositories/authentication/authentication_repository.dart';
import 'package:registro_prestamos/data/repositories/user/user_repository.dart';
import 'package:registro_prestamos/feactures/authentication/controllers/auth_controller.dart';
import 'package:registro_prestamos/feactures/pages/controllers/client_controller.dart';
import 'package:registro_prestamos/feactures/pages/controllers/registro_de_prestamo_controller.dart';
import 'package:registro_prestamos/provider/auth_provider.dart';
import 'package:registro_prestamos/provider/client_provider.dart';
import 'package:registro_prestamos/utils/connects/network_manager.dart';
import 'app.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(NetworkManager());
  await dotenv.load(fileName: ".env");
  Get.put(AuthControllers());
  Get.put(ClientController());
  Get.put(RegistroDePrestamoController());
  Get.put(UserRepository());
  Get.put(AuthenticationRepository());
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Permite solo modo vertical
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticateProvider()),
        ChangeNotifierProvider(create: (_) => ClientProvider()),
      ],
      child: App(),
    ),
  );
}

