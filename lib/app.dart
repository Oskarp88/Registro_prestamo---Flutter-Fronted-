import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestapp/controllers/theme_controller.dart';
import 'package:prestapp/splash_screen.dart';
import 'package:prestapp/utils/theme/theme.dart';

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
          home: const SplashScreen(),
        ));
  }
}