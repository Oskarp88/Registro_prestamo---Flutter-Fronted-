import 'package:flutter/material.dart';
import 'package:prestapp/common/styles/my_text_style.dart';
import 'package:prestapp/utils/constants/my_colors.dart';
import 'package:prestapp/utils/helpers/helper_funtions.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key, 
    required this.text, 
    required this.onTap
  });
 
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: THelperFuntions.screenWidth() > 350 ? 350 : double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: MyColors.esmeralda5,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: MyTextStyle.bodyLarge,
        ),
      ),
    );
  }
}