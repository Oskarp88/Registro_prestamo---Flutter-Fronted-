import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = _loadThemeFromBox();
  }

  bool _loadThemeFromBox() => _box.read(_key) ?? Get.isPlatformDarkMode;

  void saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    saveThemeToBox(value);
    Get.changeThemeMode(theme);
  }
}
