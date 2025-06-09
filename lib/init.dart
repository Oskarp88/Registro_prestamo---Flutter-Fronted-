import 'package:flutter/material.dart';
import 'package:registro_prestamos/utils/manager/assets_manager.dart';

class Init extends StatelessWidget {
  const Init({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Image(image: AssetImage(AssetsManager.clashcycle),width: 120,),
           SizedBox(height: 20,),
           CircularProgressIndicator(
             color: Colors.white,
           ),
         ],
       ),
      ),
    );
  }
}