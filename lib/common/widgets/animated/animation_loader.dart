import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestapp/common/styles/my_text_style.dart';
import 'package:prestapp/utils/constants/dimensions.dart';
import 'package:prestapp/utils/helpers/helper_funtions.dart';

class OAnimationLoaderWidget extends StatelessWidget {
  const OAnimationLoaderWidget({
    super.key, 
    required this.text, 
    required this.animation, 
    this.showAction = false, 
    this.actionText, 
    this.onActionPressed
  });
  
  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
   return Center(
     child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          animation, 
          width: THelperFuntions.screenWidth() > 350
            ? 350 
            : MediaQuery.of(context).size.width * 0.8
        ),
        SizedBox(height: Dimensions.defaultSpace,),
        showAction 
          ? SizedBox(
            height: 100,
            child: OutlinedButton(
              onPressed: onActionPressed, 
              child: Text(
                actionText!,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white
                ),
              )
            ),
          )
          :  Text(
            text,
            style: MyTextStyle.headlineSmall.copyWith(
              decoration: TextDecoration.none,
            ),
          ),
      ],
     ),
   );
  }

  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop();
  }
}