import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prestapp/utils/constants/my_colors.dart';

class Loaders {
  static hideSnackbar() => ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required message}){
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color:MyColors.blackRow.withValues(alpha: 0.8),
          ),
          child: Center(
            child: Text(
              message,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        )
      )
    );
  }
  
  static warningSnackBar({required title, message = '', int seconds = 13}){
    Get.snackbar(
      title, 
      message,
      isDismissible: false,
      shouldIconPulse: true,
      colorText: MyColors.white,
      backgroundColor: Colors.orange.shade600,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: seconds),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: Colors.white,)
    );
  }

  static successSnackBar({required title, message = '', int time = 10}){
    Get.snackbar(
      title, 
      message,
      isDismissible: false,
      shouldIconPulse: true,
      colorText: MyColors.white1,
      backgroundColor: Colors.green.shade600,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: time),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.copy_success, color: Colors.white,)
    );
  }

  static errorSnackBar({required title, message = ''}){
    Get.snackbar(
      title, 
      message,
      isDismissible: false,
      shouldIconPulse: true,
      colorText: MyColors.white1,
      backgroundColor: Colors.red.shade600,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: Colors.white,)
    );
  }
}