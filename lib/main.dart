import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:prestapp/data/repositories/authentication/authentication_repository.dart';
import 'package:prestapp/data/repositories/user/user_repository.dart';
import 'package:prestapp/feactures/authentication/controllers/auth_controller.dart';
import 'package:prestapp/feactures/pages/controllers/capital_controller.dart';
import 'package:prestapp/feactures/pages/controllers/client_controller.dart';
import 'package:prestapp/feactures/pages/controllers/registro_de_prestamo_controller.dart';
import 'package:prestapp/provider/auth_provider.dart';
import 'package:prestapp/provider/client_provider.dart';
import 'package:prestapp/utils/connects/network_manager.dart';
import 'package:provider/provider.dart';
import 'app.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_ES', null);

  await GetStorage.init();
  Get.put(NetworkManager());
  await dotenv.load(fileName: ".env");
  Get.put(AuthControllers());
  Get.put(ClientController());
  Get.put(RegistroDePrestamoController());
  Get.put(CapitalController());
  Get.put(UserRepository());
  Get.put(AuthenticationRepository());
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Permite solo modo vertical
  ]);

  ///AuthenticateProvider.instance.user!.id ---- asi puedes llamar el id
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

