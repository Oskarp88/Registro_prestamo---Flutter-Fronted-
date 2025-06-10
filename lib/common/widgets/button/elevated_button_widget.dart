import 'package:flutter/material.dart';
import 'package:registro_prestamos/utils/helpers/helper_funtions.dart';

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
    return SizedBox(
      width: THelperFuntions.screenWidth() > 350 ? 350 : double.infinity,
      child: ElevatedButton(
        onPressed: onTap, 
        child: Text(text),
      ),
    );
  }
}