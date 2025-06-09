import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registro_prestamos/init.dart';
import 'package:registro_prestamos/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: const Init()
    );
  }
}