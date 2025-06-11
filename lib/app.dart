import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registro_prestamos/controllers/theme_controller.dart';
import 'package:registro_prestamos/init.dart';
import 'package:registro_prestamos/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeController.theme,
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          home: const Init(),
        ));
  }
}